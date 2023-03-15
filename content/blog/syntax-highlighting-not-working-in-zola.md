+++
title = "Zola で Syntax Highlighting が機能しなかった問題とその解決方法"
date = 2023-03-14
tags = ["Zola", "Syntax", "GPT"]
+++

※この記事は Bing Chat で整形しました。

Zola で Syntax Highlighting が機能しなかった問題とその解決方法

Zola は静的サイトジェネレーターの一つです。Zola を使ってサイトを作成していたところ、Syntax Highlighting が機能しないという問題に遭遇しました。Syntax Highlighting とは、コードブロック内のキーワードなどに色を付けて見やすくする機能です。

この問題は、CSP (Content Security Policy) というセキュリティ機能が原因でした。CSP は、インラインのスタイル（style 属性）などを無効化することで、悪意のあるコードの実行を防ぐ機能です。しかし、Zola のデフォルト設定では、Syntax Highlighting のためにインラインのスタイルが出力されていました。そのため、CSP によって Syntax Highlighting が無効化されていたのです。

この問題を解決するには、以下の手順で Zola の設定ファイル（config.toml）を変更します。

1. highlight_theme を "css" に変更します。これは、インラインのスタイルではなく、CSS のクラス名として出力することを指定します。
2. highlight_themes_css で出力するファイル名を指定します。ここでは "dracula-dark" と "dracula-light" というテーマ名とそれぞれ対応するファイル名（syntax-theme-dark.css と syntax-theme-light.css）を指定しています。
3. extra.stylesheets で外部ファイルとして出力されたファイル（syntax-theme-dark.css）を指定します。

変更後の設定ファイルは以下のようになります。

```toml
#[markdown]
...
highlight_theme="css"
highlight_themes_css = [
    { theme = "dracula-dark", filename = "syntax-theme-dark.css" },
    { theme = "dracula-light", filename = "syntax-theme-light.css" },
]

#[extra]
...
stylesheets = ["syntax-theme-dark.css"]
````

以上で Syntax Highlighting が機能するようになります。ただ配色は期待していた `dracula` 風ではなく原因がわかっていないため、なにわかれば追記します。
