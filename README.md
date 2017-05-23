# 人感センサー+シリアルカメラ+Google Vision API

## フロー

- 人感センサーが感知
- 1.5秒後に撮影
- JEPGデータを自宅サーバーへPOST送信
- railsサーバーで受信してDBへ格納
- JPEGデータをGoogle Vision APIへ送信
- APIレスポンスをDBへ格納
- vue.jsでお気に入り登録機能や検索で思い出を振り返る
- TwitterにGoogle Vision APIの情報をツイートする


