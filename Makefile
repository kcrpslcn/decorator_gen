.PHONY: help build clean test test_coverage watch

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Build the application
	dart pub get
	dart run build_runner build --delete-conflicting-outputs

clean: ## Clean the build artifacts
	flutter clean
	rm -rf coverage

test: ## Run unit
	dart test

test_coverage: ## Run unit tests with coverage
	dart test --coverage=coverage
	dart run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --packages=.dart_tool/package_config.json --report-on=lib
	genhtml coverage/lcov.info -o coverage/html --no-function-coverage
ifeq ($(SILENT), true)
	@echo "Done"
else 
	open coverage/html/index.html
endif

upgrade: ## Upgrade dependencies
	dart pub upgrade

watch: ## Watch for changes and rebuild
	dart pub get
	dart run build_runner watch --delete-conflicting-outputs