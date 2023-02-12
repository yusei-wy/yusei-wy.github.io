+++
title = "GitHub Pagesで始める開発ブログ"
date = 2023-02-12
+++

始めましてエンジニアの yusei-wy です。
2023年はアウトプットを増やしたいと考えていて開発ブログを再開することにしました。  
以前は Hugo を使っていたのですが、数記事で更新が止まってしまったので心機一転新しく始めることに。  
最近は Astro などいろいろな静的サイトジェネレーターがありますが、結果としては最近は Rust に興味があるので今回は [Zora](https://www.getzola.org/documentation/getting-started/overview/) を選択。


## 環境構築

1. `brew install zola`
1. `mkdir blog && cd blog`
1. `zola init`



## 検索

Zola には検索機能がありますが、対応しているのは英語のみ。日本語に対応するには一手間必要。
[Japanese full-text search using Elasticlunr in Zola](https://www.jpgov.art/posts/japanese-full-text-search-on-zola/)

まず検索機能は無効化して始め必要になったら調べる方針にしました。

`config.toml`

```toml,lineos:config.toml
build_search_index = false
```


## デプロイ

GitHubPages にデプロイする手順

1. public リポジトリを GitHub 上に作成
2. ナビゲーションの [Settings] を選択
3. サイドバーの  Code and automation から [Pages] を選択
4. Branch をメインブランチに設定
5. フォルダは `docs/` を選択
6. [保存] で公開

以降は選択したブランチに push するだけで最新版が公開される。

