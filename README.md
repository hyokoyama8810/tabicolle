# Tabicolle (タビコレ)

## URL

https://tabicolle.herokuapp.com/

画面中央部のゲストログインボタンから､メールアドレスとパスワードを入力せずに､簡単にログインできます｡

## イメージ図

![Tabicolleのイメージ図](./app/assets/images/readme01.png "Tabicolleのイメージ図")

## 概要

**Tabicolleは,旅行好きたちが旅の思い出を残したり,次なる旅行先を探すことを助けるアプリケーションです.**

1. 日記感覚で旅行を記録することで何度でも旅の思い出が蘇ります｡
2. 新しい旅行のプランが見つかります｡

## 使用例

### 週末予定のないとあるグループ

>A君:今週末どっか行かない??
>
>B君:いいね｡どっか行こう!!
>
>C君:どこにする??
>
>A君:すなば珈琲行ってみたいし､鳥取砂丘とかどう?? (本アプリの鳥取砂丘のタグがついた投稿を見せる)
>
>><img src="./app/assets/images/readme03.png" width="400" alt="Tabicolle鳥取砂丘のイメージ図">

>
>B君,C君:そこにしよう!!

### 京都観光している時に次の行くところ､やることが見つかっていないグループ

>Aさん:今から､何しようか??
>
>(京都のタグのついた投稿を見る)
>
><img src="./app/assets/images/readme02.png" width="350" alt="Tabicolle京都のイメージ図">
>
>Bさん:清水寺に行ってみたいな!
>
>Cさん:いいよ!!
>
>Aさん:そうだね!行こう!!


## 実装した機能

- ユーザーの新規登録･編集機能(Devise)
- ログイン･ログアウト機能(Devise)
- Googleアカウントでの認証･ログイン機能(omniauth-google-oauth2)
- 旅行記録投稿･編集機能
  - タグ機能(acts-as-taggable-on, エリアタグ,ジャンルタグ,シーズンタグ,フリータグ)
  - 画像アップロード機能(ActiveStorage, AmazonS3)
  - フォロー､フォロワー機能
  - Ajaxでのいいね機能

## 使用技術

### フロントエンド
- HTML/CSS
- Sass(SCSS)
- Bootstrap

### バックエンド
- Ruby : 2.6.6
- Rails : 6.0.3.2

#### テストフレームワーク
- RSpec

#### コード解析･整形ツール
- RuboCop

### データベース
- PostgreSQL(本番環境)
- MySQL(開発環境､テスト環境)

### インフラ
- Heroku
- AWS(S3)

### その他ツール
- Github(コード管理)
- [ロゴメーカー](https://logo-maker.stores.jp/)(ロゴ作成ツール)
