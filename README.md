# Ruby の型付け RBS 基礎

## RBS って何それ美味しいの？

[RBS](https://github.com/ruby/rbs)（Ruby Signature）とは、Ruby3.0 から導入された Ruby の型の定義情報を提供する仕組み。
RBS は言語の定義の役割を担っており、他のライブラリと組み合わせることで、Ruby の型付けを可能にしている。

大規模プロジェクトにおいて、静的型付け言語の持つ「保守性」という強みを、動的型付け言語の静的解析といったアプローチで Ruby でも「保守性」実現できるようにした。
また、Ruby のアプローチは既存の Ruby の書き心地を重視すべく、「型の情報は既存の Ruby コードとは完全に分離する」という形をとっている。
よって、「シンプルさ」「書いていて楽しい」といった Ruby 本来の持ち味を活かし続けながらパフォーマンス向上を実現している。

- 使用するライブラリ

  [TypeProf](https://github.com/ruby/typeprof)：型情報をもたない Ruby コードを型レベルで解析し、メソッドの方を推測するライブラリ。

  [Steep](https://github.com/soutaro/steep/tree/master)：RBS で宣言された Ruby コードのプログラム構造をチェックするライブラリ。

---

## セッティング（コマンドライン）

- インストール

```
$ gem install rbs
$ gem install typeprof
$ gem install steep
```

- セットアップ

```
$ steep init    # Steepfile の生成
```

---

## 使用法

例として以下のようなプログラムを用意する。

```./src/origin.rb
class Student
    attr_reader :name, :number
    attr_accessor :grade, :credit

    def initialize(name, grade, number, credit)
        @name = name
        @grade = grade
        @number = number
        @credit = credit
    end

    def up_grade
        base = 40
        @grade += 1 if @credit > (base * @grade)
    end

    def get_credit(n)
        @credit += n
        "単位が#{n}増えました"
    end

    def get_student(str)
        if str == @number
            "#{@name}は、現在#{@grade}年生です"
        else
            nil
        end
    end
end
```

この場合以下のような`rbs`ファイルを作成することができる。

```./sig/origin.rbs
# Classes
class Student
  attr_reader name: String
  attr_reader number: String
  attr_accessor grade: Integer
  attr_accessor credit: Integer

  def initialize: (String name, Integer grade, String number, Integer credit) -> void
  def up_grade: -> void
  def get_credit: (Integer n) -> String
  def get_student: (String str) -> String?
end
```

また、デフォルトの`rbs`ファイルはコマンドラインから自動生成できる。

```
# 書き方
$ typeprof 'Rubyファイル名' > 'RBSファイル名'

# 例
$ typprof src/origin.rb > sig/origin.rbs
```

宣言した Ruby の型をチェックするには Steepfile を作成したのちに、以下のようなコードを記述する。

```./Steepfile
target :src do
    check 'src'         # 型チェックをしたいRubyファイルが格納されているディレクトリ名
    signature 'sig'     # 型定義が記述されているRBSファイルが格納されているディレクトリ名

    library 'date'      # 使用するライブラリの指定
end
```

そして、コマンドラインで型チェックを実行すると、結果が出力される。

```
$ steep check
```

- **重要なポイント**

  ・プログラム構造の定義(RBS)ファイルは、基本的に sig(signature)ディレクトリに配置する。

  ・rbs は自身で書くこともできるが、typeprof を使用することでデフォルトコードを自動生成できる。

  ・Steep の検査は、呼び出しが記述されているコードが対象となっている。

---

## 参考ページ

・[Ruby3 で導入される静的型チェッカーのしくみ　まつもとゆきひろ氏が RubyKaigi 2019 で語ったこと](https://logmi.jp/tech/articles/321280)

・[社内 Ruby3 新規機能勉強会資料 〜RBS とは〜](https://qiita.com/getty104/items/9a2a20a6e170ab53191c)

・[Steep を使って Ruby の型検査に入門する](https://qiita.com/kettomorrow/items/8ccada8a4c9eac85b7ad)

・[Ruby で型チェック！動かして理解する RBS 入門〜サンプルコードでわかる！Ruby 3.0 の主な新機能と変更点 Part 1〜](https://qiita.com/jnchito/items/bf8c6c2e1dd6cff05f4e)

・[Ruby 3.0.0 の方チェック（rbs）を簡単に試す](https://qiita.com/TokyoYoshida/items/06372ed32cdd0617a431)

・[Ruby 3 の静的解析機能の RBS、TypeProf、Steep、Sorbet の関係についてのノート](https://techlife.cookpad.com/entry/2020/12/09/120454)

・[Ruby の静的型付けについて（RBS, TypeProf, Steep, Sorbet）](https://blog.share-wis.com/typinginruby)
