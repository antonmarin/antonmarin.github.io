.DEFAULT_GOAL := help

help:
	@printf "\
		lint\t prebuild validations \n\
		serve\t serve jekyll dev server \n\
		test\t test building jekyll \n\
	"

lint:
	docker run --rm -v "$(PWD):/app" -w /app markdownlint/markdownlint -i /app/_pages
	docker run --rm -v "$(PWD):/app" -w /app markdownlint/markdownlint -i /app/_posts

serve:
	docker run --rm -it -v $(PWD):/app \
		-p 4000:4000 -e JEKYLL_GITHUB_TOKEN \
		antonmarin/github-pages:latest-alpine serve -H 0.0.0.0 -P 4000 --drafts

test:
	rm Gemfile* || true
	docker run --rm -i -v $(PWD):/app \
		-e JEKYLL_GITHUB_TOKEN \
		antonmarin/github-pages:209-alpine build --future
