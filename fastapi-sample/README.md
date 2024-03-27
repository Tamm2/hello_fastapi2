## 概要

fastapi, のサンプルです  

jwt 認証を入れています。
それぞれフォーマッタが入っています。
フォルダ構成は今考え中で一旦 laravel のフォルダ構成を参考にして作りました

よく使うコマンドは Makefile にまとめてあります

環境の詳細
python: 3.10.0
docker
fasapi
想定エディタ: vscode or cursor
デバッグ: debugpy
ライブラリ管理: pipenv
orm: sqlqlchemy
mysql: 8.0
フォーマッターなど: flake8, mypy, black, isort
jwt: pyJwt

## 環境構築方法

手順 1
pc に docker が入っていない方は docker のインストールをしてください
公式サイト: https://code.visualstudio.com/download

手順 2
下記のコマンドを実行して docker の開発環境を作成します

```
make cp-env
make init
```

手順 3
下記のコマンドにて user-api サーバーを立ち上げる

```
make user-api-run
```

手順 4
ブラウザで  
http://localhost:8000/docs#/  
にアクセスして swagger が表示されれば OK

## push 時のルール

コンテナが立ち上がっている状態で下記のコマンドを実行してから push すること
フォーマッタの実行、静的解析チェックが走ります。

```
make check
```

## ライブラリのインストール方法

docker を利用しているので モジュールをインストールする場合はコンテナの中に入ってインストールする必要があります
またモジュールの管理に pipenv を使用しているため特別な方法でインストールを実行する必要があります
以下にその方法を説明します

例
numpy をインストールする方法

手順 1
下記のコマンドでコンテナの中に入ります

```
make user-api-shell
```

手順 2
下記のコマンドで numpy をインストールします

```
pipenv install numpy
```


## vscode で debugpy によるデバッグの方法

vscode で debugpy によるデバッグ方法を説明します
参考: https://atmarkit.itmedia.co.jp/ait/articles/2107/16/news029.html

`python/src/sample.py` をデバッグする方法

手順 1
vscode のプラグインの XXX をインストールします

手順 2
`python/src/sample.py` のデバッグのコメントアウトを外します

手順 3
「python の実行方法」を参考に実行し `python/src/sample.py` を実行します

手順４
コンソールを確認すると

```
waiting ...
```

と表示されていることを確認

手順 5
自分がデバッグを開始したい箇所にブレークポイントをセットします

手順 6
F5 のキーを押します
デバッグが開始されます。

## python コードのフォーマット、静的解析について

python にはプログラミングコードの品質を保つため、お勧めされているコードフォーマットや静的解析があります。
下記のコマンドを実行することで python 配下の python コードが自動で整形がされ、また静的解析が行われます。

```
make check
```

## マイグレーションについて

`app/models`配下に定義してあるテーブルが管理されます
新しくモデルのファイルを追加した場合は`app/models/__init__.py`に追記をする必要があります
下記のコマンドを実行することでマイグレーションとマイグレートが実行できます

### マイグレーション作成

```
pipenv run alembic revision --autogenerate -m 'comment'
```

### マイグレート

```
pipenv run alembic upgrade head
```

## push 際のルール

下記のコマンドを実行してから push すること

```
make check
```

