FROM python:3.10

RUN apt-get update
# RUN apt-get -y install locales \
#     localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

WORKDIR /app

# project配下に.vnvを作成する
ENV PIPENV_VENV_IN_PROJECT 1

# log出力をリアルタイムにする
ENV PYTHONUNBUFFERED 1

# キャッシュを作成しない
ENV PYTHONDONTWRITEBYTECODE 1

ENV PYTHONPATH "/app"

# デバッグ用
EXPOSE 9000

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools pipenv

COPY ./ /app/
RUN pipenv install --dev