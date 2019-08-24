---
title: 'WorkLog① - Chrome 拡張の環境構築'
date: 2019-08-17T12:09:50+09:00
toc: false
images:
tags:
  - Chrome拡張
  - create-react-app
  - React
  - TypeScript
---

業務でタスクにかかった時間をまとめて提出するのですが、テキストファイルで管理するのは面倒。あとで集計するのも面倒。  
なのである程度自動化しようと思い、ツールを開発することにしました。

デスクトップアプリでは時間がかかりそうだったので、Chrome の拡張機能としてパパっと開発することにしました。

基本的には以下のページを参考にしています。  
https://medium.com/better-programming/create-a-chrome-extension-using-react-and-typescript-50e94e14320c

## プロジェクトの作成

---

React と TypeScript を使って拡張機能を開発するので、必要なパッケージをインストールしプロジェクトを作成します。

```
$ npm i -g create-react-app
$ create-react-app my-app --typescript
$ cd my-app
```

## エラーチェックとフォーマット

---

エラーチェックとコードフォーマットのために eslint と prettier をインストールします。

```
$ yarn add -D husky lint-staged prettier eslint eslint-plugin-react eslint-plugin-prettier eslint-config-prettier eslint-plugin-import @typescript-eslint/{parser,eslint-plugin}
```

`.eslintrc.js` ファイルを作成しエラーチェックとコードフォーマットを有効化します。

```js
module.exports = {
  env: {
    browser: true,
    es6: true,
    node: true,
    jest: true
  },
  extends: ['eslint:recommended', 'plugin:react/recommended', 'plugin:@typescript-eslint/recommended'],
  parserOptions: {
    ecmaFeatures: {
      jsx: true
    },
    ecmaVersion: 2018,
    sourceType: 'module'
  },
  plugins: ['import', 'prettier', 'react'],
  rules: {
    'prettier/prettier': [
      'error',
      {
        semi: true,
        singleQuote: true,
        printWidth: 120,
        tabWidth: 2
      }
    ],
    '@typescript-eslint/explicit-function-return-type': 'off',
    '@typescript-eslint/no-unused-vars': [
      'off',
      {
        argsIgnorePattern: '^_'
      }
    ],
    '@typescript-eslint/no-use-before-define': 'off',
    // ordered-imports - tslint
    'import/order': [
      'error',
      {
        groups: [['external', 'builtin'], ['internal', 'index', 'sibling', 'parent']]
      }
    ],
    'no-console': 'warn'
  },
  settings: {
    react: {
      version: 'detect'
    }
  }
};
```

`package.json` を編集します。

```json
{
  "scripts": {
    ...
    "test"
    "fmt": "prettier --write src/**/*.{js,jsx,ts,tsx}",
    "lint": "eslint --fix src/**/*.{js,jsx,ts,tsx}"
  },
  ...
  "husky": {
    "hooks": {
      "pre-commit": "npm run fmt && npm run lint && npm run test"
    }
  }
}
```

## Manifest File

---

Chrome 拡張には Manifest File が必要です。
拡張機能の名前と説明、使用する API のパーミッションの設定などを .json ファイルとして記述します。
`public/manifest.json` を以下の内容に書き換えます。

```json
{
  "manifest_version": 2,
  "version": "0.0.1",
  "name": "アプリ名",
  "short_name": "12文字以内のアプリ名",
  "description": "アプリ説明文",
  "icons": {
    "16": "icon16.png",
    "48": "icon48.png",
    "128": "icon128.png"
  },
  "browser_action": {
    "default_icon": {
      "16": "icon16.png",
      "48": "icon48.png",
      "128": "icon128.png"
    },
    "default_title": "worklog",
    "default_popup": "index.html"
  }
}
```

Manifest File の内容に合わせて icon も `public/` 内に用意しておいてください。

## ビルド

---

以下のコマンドを実行してプロジェクトをビルドします。  
すると `build/` 以下にファイルが生成されます。

```
$ yarn build
```

## Chrome にビルドした拡張機能の読み込み

---

1. chrome://extensions/ にアクセス
1. [デベロッパーモード]を ON
1. [パッケージ化されていない拡張機能を読み込む]をクリック
1. `build/` ディレクトリを選択

するとツールバーにアイコンが表示されるのですが、クリックしてもポップアップには何も表示されません。  
原因は `<script>` タグで JS がインライン展開されているため、CSP(Content Security Policy) に違反しているためです。  
解決するために `.env` ファイルをルートフォルダに作成して以下を書き込みます。

```
INLINE_RUNTIME_CHUNK=false
```

そして `yarn build` し直して、拡張機能を読み込めば完了です。

## テスト

---

テスト環境を構築します。  
create-react-app でプロジェクトを作成するとデフォルト Jest がインストールされるので、 `enzyme` というパッケージを追加でインストールすることで、React でのテストが容易になります。

```
$ yarn add -D @types/enzyme @types/enzyme-adapter-react-16 enzyme enzyme-adapter-react-16
```

このまま書き始めると Adapter が有効にならないので `src/setupTests.ts` ファイルを作成して以下を書き込みます。

```ts
import Adapter from 'enzyme-adapter-react-16';
import Enzyme from 'enzyme';

Enzyme.configure({ adapter: new Adapter() });
```

そして `src/App.test.tsx` に簡単なテストを書きます。

```tsx
import { shallow } from 'enzyme';
import App from './App';

test('There is a string "Welcom to React"', () => {
  const wrapper = shallow(<App />);
  expect(wrapper.text()).toContain('Welcom to React');
});
```

```
$ yarn test
```

テストを実行して通れば OK です。

長くなったので、一旦ここで締めます。  
実際の開発は次回の[開発編]({{<ref "">}})で説明したいと思います。

