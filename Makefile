.PHONY: clean
clean:
	flutter clean
	flutter pub get

.PHONY: format
format:
	dart fix --apply
	flutter pub run import_sorter:main
	dart format lib/* test/*
	flutter analyze

.PHONY: builder
builder:
	flutter pub get
	dart run build_runner clean
	dart run build_runner build --delete-conflicting-outputs