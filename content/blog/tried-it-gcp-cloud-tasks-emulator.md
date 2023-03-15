+++
title = "GCP CloudTasks Emulator 試してみた"
date = 2023-03-15
tags = ["CloudTasks", "GCP", "Go"]
+++

今日は Google Cloud Tasks をローカルでエミュレートしてみたので、手順や詰まったポイントをまとめました。

## はじめに

作業環境を構築とパッケージの取得
```sh
go mod init cloudtasks_emulator_example
go get cloud.google.com/go/cloudtasks/apiv2
go get cloud.google.com/go/cloudtasks/apiv2/cloudtaskspb
go get -u github.com/gin-gonic/gin
```

`docker-compose.yml`
```yml
version: '3'
services:
  app:
    build:
      context: .
      dockerfile: ./Dockerfile
    ports:
      - "${APP_PORT}:8080"
    env_file:
      - .env
    volumes:
      - ./:/go/src
    tty: true

  gcloud-tasks-emulator:
    image: ghcr.io/aertje/cloud-tasks-emulator:latest
    command: -host 0.0.0.0 -port 8123
    ports:
      - "${TASKS_PORT:-8123}:8123"
    env_file:
      - .env
```

`Dockerfile`
```Dockerfile
FROM golang:1.20-bullseye

WORKDIR /go/src
COPY ./ .

RUN go install github.com/cosmtrek/air@latest

CMD ["air", "-c", ".air.toml"]
```

`.env`
```env
APP_PORT=8000
APP_ENGINE_EMULATOR_HOST=http://localhost:8000
# <PROJECT_ID> や <LOCATION_ID> は何でもいい
CLOUD_TASKS_PARENT=projects/dev/locations/here
```

hot reload するための air を初期化
```sh
docker-compose run --rm app air init
```


## Cloud Tasks Emulator にリクエスト

まずは docker container の起動
```sh
docker compose up --build
```

実装
```go
package main

import (
	"context"
	"log"
	"net/http"
	"os"

	cloudtasks "cloud.google.com/go/cloudtasks/apiv2"
	"cloud.google.com/go/cloudtasks/apiv2/cloudtaskspb"
	"github.com/gin-gonic/gin"
	"google.golang.org/api/option"
	taskspb "google.golang.org/genproto/googleapis/cloud/tasks/v2"
	"google.golang.org/grpc"
)

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
	r.GET("/queues/:queue_id", testqueue)
	r.Run()
}

func testqueue(c *gin.Context) {
	ctx := context.Background()
	queueId := c.Param("queue_id")

	conn, err := grpc.Dial("gcloud-tasks-emulator:8123", grpc.WithInsecure())
	if err != nil {
		log.Fatalf("gRPC Dial: %v", err)
	}
	defer conn.Close()

	clientOpt := option.WithGRPCConn(conn)
	client, err := cloudtasks.NewClient(ctx, clientOpt)
	if err != nil {
		log.Fatalf("cloudtasks NewClient: %v", err)
	}
	defer client.Close()

	_, err = createQueue(ctx, conn, client, queueId)
	if err != nil {
		log.Fatalf("%v", err)
	}

	parent := os.Getenv("CLOUD_TASKS_PARENT")
	createTaskRequest := taskspb.CreateTaskRequest{
		Parent: parent + "/queues/" + queueId,
		Task: &taskspb.Task{
			MessageType: &taskspb.Task_HttpRequest{
				HttpRequest: &taskspb.HttpRequest{
					Url: "https://yahoo.co.jp",
				},
			},
		},
	}
	createdTask, err := client.CreateTask(ctx, &createTaskRequest)
	if err != nil {
		log.Fatalf("client CreateTask: %v", err)
	}

	c.String(http.StatusOK, createdTask.String())
}

func createQueue(
	ctx context.Context,
	conn *grpc.ClientConn,
	client *cloudtasks.Client,
	queueId string,
) (*cloudtaskspb.Queue, error) {
	parent := os.Getenv("CLOUD_TASKS_PARENT")
	createQueueRequest := taskspb.CreateQueueRequest{
		Parent: parent,
		Queue:  &cloudtaskspb.Queue{Name: parent + "/queues/" + queueId},
	}
	createQueueResp, err := client.CreateQueue(ctx, &createQueueRequest)
	if err != nil {
		return nil, err
	}

	return createQueueResp, nil
}
```

`/queues/:queue_id` にアクセスすることで任意の queue とタスクを作成して実行できる。


## Queue を作成するタイミングでエラーが発生

```
rpc error: code = InvalidArgument desc = Queue name must be formatted: "projects/<PROJECT_ID>/locations/<LOCATION_ID>/queues/<QUEUE_ID>"
```

Go のサンプルでは以下のように `taskspb.CreateQueueRequest` を生成している
```go
createQueueRequest := taskspb.CreateQueueRequest{
    Parent: parent,
    Queue: parent + "/queues/test",
}
```

正しくはこちら
```go
createQueueRequest := taskspb.CreateQueueRequest{
	Parent: parent,
	Queue:  &cloudtaskspb.Queue{Name: parent + "/queues/test"},
}
```


## 本番で利用するなら

プロジェクト ID には Cloud Tasks API を有効にした Project ID を指定する。

ロケーション ID は以下のコマンドで確認して、該当するものを指定
```sh
gcloud tasks locations list
```


## 参考

[https://github.com/aertje/cloud-tasks-emulator](https://github.com/aertje/cloud-tasks-emulator)
