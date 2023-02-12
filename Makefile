DATETIME = $(shell date "+%Y-%m-%d %H:%M:%S")

serve:
	zola serve

build:
	zola build

deploy:
	make build
	git commit -m "deploy $()"
	git push -u origin main
