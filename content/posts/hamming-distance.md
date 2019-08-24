---
title: "ハミング距離"
date: 2019-04-16T20:08:32+09:00
toc: false
images:
tags:
  - アルゴリズム
---

## ハミング距離とは

---

> 等しい文字数を持つ二つの文字列の中で、対応する位置にある異なった文字の個数
> 出典：[ハミング距離](https://ja.wikipedia.org/wiki/%E3%83%8F%E3%83%9F%E3%83%B3%E3%82%B0%E8%B7%9D%E9%9B%A2)

例えば

```
1001001
1000101
```

このハミング距離は"2"

```
2239567
2459587
```

このハミング距離は"3"

```
helloworld
hollndorld
```

このハミング距離は"3"

## 求め方

---

ソースコードで表すと

```python
str1 = "1001001"
str2 = "1000101"

cnt = 0
for s1, s2 in zip(list(str1), list(str2)):
    if s1 is not s2:
        cnt += 1
print(cnt)  # 2
```

簡単ですね。
