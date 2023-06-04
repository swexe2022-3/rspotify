# RSpotify

RSpotify gemを利用したspotify apiによるwebアプリケーション.

## Specification

- Ruby 2.6.3
- Rails 5.2.8
- node.js と npm が必要です.
- .envファイルにspotifyAPIから登録したキーを入力する必要があります.

## Services 

-twitterのようなフォーロー機能

-フォーローの人が最近聞いている曲と自分が最近聞いている曲のランキングをプレイリストとして表示

-ランキングをspotifyのアカウントにプレイリストとして入れられる

-最近聞いている曲の状態がわかる

-[![紹介動画](https://img.youtube.com/vi/Q0ouQ1K73oU/0.jpg)](https://www.youtube.com/watch?v=Q0ouQ1K73oU)

## Deployment instructions

```bash
$ bundle install
$ rails db:migrate
$ rails s
```
