---
title: "職務経歴書"
date: 2019-05-03T09:47:08+09:00
robots: "noindex,nofollow,noarchive"
---

## プロフィール

---

* 氏名：笠原 悠聖(Kasahara Yusei)
* Twitter：[@yusei_wy](https://twitter.com/yusei_wy)
* GitHub：[yusei-wy](https://github.com/yusei-wy)
* GitHub(会社用)：[amatakasap](https://github.com/amatakasap)
* Qiita(会社用)：[@amatakasap](https://qiita.com/amatakasap)

## 職務経歴（概要）

---

* スマホアプリの開発
  * 設計 / 制作：5年
  * プログラミング：5年
* Web フロントエンド開発
  * JavaScript / HTML / CSS 6年以上
* その他ソフトウェア開発
  * CLI ツール (Linux / C / Go / Python)
  * スクレイピングツール (Python）
  * スマホアプリ自動操作マクロ（UWSC）

## プログラミングスキル

---

### JavaScript / TypeScript
  * 2013年から日常的に利用。Web ページにちょっとした動きをつけたり、SPA(シングルページアプリケーション)の開発まで経験。
  * 普段は ES(ECMAScript)6 を利用し、最新技術も polifill で積極的に導入して活用。
  * jQuery Mobile / AngularJS / Riot.js / Vue.js / Nuxt.js を利用した開発経験あり。

### Objective-C
  * 2014年に WebRTC を活用した iOS 用ビデオ通話アプリを開発。
  * 2016年以後は Cordova でネイティブ機能を呼び出すためにプラグインの改良をする程度。

### Java
  * 2014年に WebRTC を活用した Android 用ビデオ通話アプリを開発。
  * 2016年以後は Cordova でネイティブ機能を呼び出すためにプラグインの改良をする程度。

### Python
  * Web サイトのスクレイピングツールの開発。
  * [ニコニコ動画から動画をダウンロードするソフト開発](https://github.com/yusei-wy/nicodl)。
  * Django 趣味レベルのアプリランキングサイトの作成。

#### C
  * Linux コマンド  
    『ふつうの Linux プログラミン』を読んで cat, grep, httpd などのコマンドを開発。
  * [MonoLis](https://github.com/yusei-wy/MonoLis)  
    『やさしい Lisp の作り方』で簡単な Lisp 処理系の開発。
  * [HariboteOS](https://github.com/yusei-wy/HariboteOS)  
    『OS 自作入門』を読んで20日目あたりまで Ubuntu で OS の開発。完成はしていませんが、Linux の知識が深まりポインタやアセンブラへの苦手意識が薄まりました。

### Rust
  * [rucky](https://github.com/yusei-wy/rucky)  
    インタプリンタ。開発中。
  * [r9cc](https://github.com/yusei-wy/r9cc)  
    C コンパイラ。開発中。

### Go
  * 画像にグレースケールを施したり、リサイズする CLI ツールの開発。

### その他
  * Git や GitHub / GitLab を使ったバージョン管理。
  * Gulp / Grunt / Webpack / Rollup を使ったフロントエンド開発。

## 職務経歴

---

### 株式会社アマタ（2011/07〜現在）

- 2018/12〜5ヶ月 - ギフトプレゼントができるマッチングアプリの開発
  - フロントエンド全般を担当
  - Android/iOS 対応の Cordova を使用したハイブリットアプリ(TypeScript / SCSS)
  - フレームワークに Vue.js を使用
  - 前回のアプリ開発時にコンポーネント志向な設計を行っていたためかなり流用でき比較的早く完成できました
  - Cordova でのアプリ開発にもかなり慣れていたので、プラグインで複数のバグを発見し GitHub でプルリクエストを送信して実際にマージされることもありました。

- 2017/12〜6ヶ月 - マッチングアプリの開発  
[Google Play Store](https://play.google.com/store/apps/details?id=com.aizuchat.app&hl=ja)  
[App Store](https://itunes.apple.com/jp/app/aizu-%E3%83%A9%E3%82%A4%E3%83%96%E3%83%81%E3%83%A3%E3%83%83%E3%83%88-%E3%83%93%E3%83%87%E3%82%AA%E9%80%9A%E8%A9%B1/id1357911124?mt=8)
  - フロントエンド全般を担当
  - Android/iOS 対応の Cordova を使用したハイブリットアプリ(TypeScript / SCSS)
  - フレームワークに Vue.js を使用
  - WebRTC ライブラリ OpenTok を用いた音声・ビデオ通話機能の実装
  - Web でネイティブ並みのパフォーマンスをだすために仮想スクロールのや先読みで遅延のないページ遷移の実装
  - 自由度の高い Android だけでなく iOS でも CallKit や VoIP Push を活用し使いやすい通話機能を実装
  - 内部的には SPA として開発されているので Web アプリとしてもリリース。一部の機能（通話機能など）を除いてネイティブとほぼ同じ操作性を実現させるためにネイティブコンポーネントを Vue のコンポーネントとして再現。
  - 社内でタスク管理ソフトを使う文化がなかったので Trello を導入してタスクを可視化してチーム全員で共有できるようにしました。

- 2016/07〜6ヶ月 - ビデオ通話アプリの Cordova への移植  
[Google Play Store](https://play.google.com/store/apps/details?id=jp.tomosin.minmin&hl=ja)  
[App Store](https://itunes.apple.com/jp/app/minmin/id890353434?mt=8)
  - フロントエンド全般を担当
  - 管理しやすいように Objective-C と Java で開発していた既存のネイティブアプリを Cordova に移植
  - フレームワークには Riot.js を使用
  - WebRTC ライブラリ OpenTok を使用してビデオ通話を実装

- 2016/04〜1週間 - WordPress への記事自動投稿ツール開発
  - Python の Selenium でブラウザを操作して指定された内容の記事を自動的に投稿するプログラムを開発

- 2016/04〜1週間 - スクレイピングツール
  - Python と Selenium で JavaScript で動的に生成されたページをスクレイピングするプログラムを開発
  - pyenv, virtualenv, Anaconda などを使った環境構築を経験

- 2016/01〜6ヶ月 - スマートフォン用ライブチャットのサイトの制作
  - HTML のコーディングと JavaScript のロジックに作業を分担してフロントエンドは2人で開発。JavaScript を担当
  - フレームワークには AnguarJS を採用
  - Web だけではビデオ通話機能を実現できなかったため自社開発のスマホ用ビデオ通話アプリと連動できるように対応
  - CSS フレームワークとして Onsen UI を用いることでネイティブアプリのような UI を実現

- 2014/07〜5ヶ月 - Android 向けビデオ通話アプリ開発
  - フロントエンド全般を担当
  - Java でネイティブアプリとして開発
  - WebRTC ライブラリ OpenTok を用いた音声・ビデオ通話機能の実装

- 2014/01〜6ヶ月 - iOS 向けビデオ通話アプリ開発
  - フロントエンド全般を担当
  - Objective-C でネイティブアプリとして開発
  - WebRTC ライブラリ OpenTok を用いた音声・ビデオ通話機能の実装

- 2013/08〜3ヶ月 - Android を対象にしたビデオ通話 Web アプリ開発
  - 自社で運用するサイトでスマホでもビデオ通話ができるように JavaScript で WebRTC と Node.js を使って開発
  - 通話のたびにカメラやマイク許可設定が必要だったり iOS では WebRTC に対応してなかったことから公開されていません
