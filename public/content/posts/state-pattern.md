---
title: "State パターン"
date: 2019-06-07T19:28:31+09:00
toc: false
images:
tags:
  - デザインパターン
---

最近は『{{< exlink href="https://www.amazon.co.jp/dp/B01IGW5MG0/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1" text="リファクタリング　既存のコードを安全に改善する" >}}』という本を読んでいます。  
第 1 章で説明されていた State パターンについてのメモです。

## State パターン（state pattern, ステート・パターン）とは

---

一般的なオブジェクト指向のプログラミング言語では、オブジェクトは自分が属するクラスを生存期間中に変更できない。
この解決策が State パターン。

> プログラミングで用いられる振る舞いに関する（英語版） デザインパターンの一種である。このパターンはオブジェクトの状態（state）を表現するために用いられる。ランタイムでそのタイプを部分的に変化させるオブジェクトを扱うクリーンな手段となる  
> 出典：[State パターン](https://ja.wikipedia.org/wiki/State_%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)

例えば

{{\< mermaid align="left" \>}}
sequenceDiagram
participant Alice
participant Bob
Alice->>John: Hello John, how are you?
loop Healthcheck
John->John: Fight against hypochondria
end
Note right of John: Rational thoughts <br/>prevail...
John-->Alice: Great!
John->Bob: How about you?
Bob-->John: Jolly good!
{{\< /mermaid \>}}
