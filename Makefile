DATETIME = $(shell date "+%Y-%m-%d %H:%M:%S")

serve:
	zola serve

build:
	zola build

deploy:
	make build
	git add .
	git commit -m "deploy $(DATETIME)"
	git push -u origin main
	echo deployed
