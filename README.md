# calender_application

## コマンド
```dart
make format
```

```dart
make build
```

```dart
make clean
```

## コード生成 makefile案
https://qiita.com/isekiryu/items/67d081671fe8c9fba0b9


## アナライズで除外されているルール

- public_member_api_docs:

パブリックAPIのメンバにドキュメンテーションコメントを要求するルールです。
falseに設定すると、パブリックメンバにドキュメンテーションコメントがなくても警告やエラーが発生しません。
- one_member_abstracts:

抽象クラスが一つのメンバのみを持つ場合に警告を出すルールです。
このルールを無効化すると、一つのメンバのみを持つ抽象クラスが許容されます。
- sort_pub_dependencies:

pubspec.yamlファイル内の依存関係をアルファベット順に並べることを要求するルールです。
このルールを無効化すると、依存関係の順序はチェックされません。
- depend_on_referenced_packages:

プロジェクトが参照しているパッケージに明示的に依存することを要求するルールです。
このルールを無効化すると、参照されているパッケージがpubspec.yamlにリストされていなくても問題になりません。
- directives_ordering:

ソースファイル内のディレクティブ（import、export、part文など）の順序を規定するルールです。
このルールを無効化すると、ディレクティブの順序はチェックされません。


