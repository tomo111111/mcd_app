![6719](https://user-images.githubusercontent.com/60236933/93545072-7f0c1700-f99a-11ea-9402-a3e1a94a61da.png)

# アプリケーション名
### 原材料発注管理アプリ

# アプリケーション概要
架空のファストフード店の発注業務をサポートするイメージで作成しました。メインの機能は納品数の自動算出機能です。このアプリケーションを使用することで作業のばらつきやミスの軽減、業務の時間短縮等が期待できます。また、実際の現場で起こりうる事象（製造工場のメンテナンスによる納品日の変更、新商品の販売、売上の変化等）を想定したサポート機能もいくつか実装しています。

### 接続先情報
 https://mcd-app-2020.herokuapp.com/  

ID/Pass
- ID: tomohiro
- Pass: 28811  
 
テスト用アカウント
- Store number: 306000
- Password: mcd306000

# 開発環境
Ruby / Ruby on Rails / JavaScript / MySQL / GitHub / Heroku / Visual Studio Code

# 目指した課題解決
自分自身の過去の経験から飲食店の発注業務には課題があると感じていました。大手であっても一部の発注業務は手計算によるもので、計算ミスや人による作業のばらつきで毎月少なくない量の食品ロスが出ていました。逆に過少発注によりお客様に商品を販売できないという経験もありました。この原材料発注管理アプリを使用することで発注担当者の負担を軽減できればと思います。

# 利用方法
### ログイン/ログアウト
- 業務用を想定していますので通常は新規登録画面は表示されません。  
- 店舗別に与えられた番号とパスワードでログインするため全てのデータは店舗ごとに分けて管理されています。

### 一覧表示（トップページ）
<img width="1680" alt="スクリーンショット 2020-09-18 11 56 59" src="https://user-images.githubusercontent.com/60236933/93550397-44a87700-f9a6-11ea-959b-48440be90531.png">

- 当日含む前後1週間の納品実績（及び予定）、使用実績、在庫実績を表示しています。  
- また、コメントボタンを押すことでその日のコメントの登録・閲覧・削除が行えます。（非同期通信）

### 実績入力
<img width="1680" alt="スクリーンショット 2020-09-18 11 57 54" src="https://user-images.githubusercontent.com/60236933/93550413-4ffba280-f9a6-11ea-9e20-831d8b995c30.png">

- 基本的には当日の使用数、在庫数、売上実績の登録を行います。日付選択後入力画面が表示されます。翌日以降の納品数の計算に使用されます。  
- また、過去日のデータの修正や、自動算出された翌日以降の納品数の修正も可能です。

### セールス予測
<img width="1680" alt="スクリーンショット 2020-09-18 12 01 22" src="https://user-images.githubusercontent.com/60236933/93552417-67895a00-f9ab-11ea-96ac-0e4572dffbba.png">

- 当月、翌月の売上予測を登録します。予測に変更が発生した場合はそのまま上書きが可能です。売上実績は実績入力画面から行います。  
- ここで入力された値は納品数の計算に使用されます。

### 原材料設定
<div align="center">
 <img src="https://user-images.githubusercontent.com/60236933/93552058-758aab00-f9aa-11ea-910c-6a5fd95d8c7c.gif" alt="" title="原材料設定DEMO">
</div>
- 基準在庫数変更：各種原材料の基準在庫数（予備在庫）をそれぞれの店舗に合った最適な値に設定できます。  
- 新規アイテム追加：新商品の販売に伴い追加される原材料をこちらから登録できます。同時に基準在庫数も登録できます。  
- 既存アイテム削除：販売品目の変更や期間限定商品の終了に伴い未使用になった原材料を削除できます。

### 配送日設定
<img width="1680" alt="スクリーンショット 2020-09-18 12 32 14" src="https://user-images.githubusercontent.com/60236933/93552452-753edf80-f9ab-11ea-86ee-0c210c3c89c6.png">

- 設定項目が2つあります。どちらも納品数の自動計算に影響を与える項目です。  
- 配送曜日設定：基本の配送パターンを登録できます。店舗ごとに配送パターンが違うため個別に設定ができます。  
- 特別配送日設定：基本の配送パターンではカバーできない配送日を登録できます。設定した日付が過ぎると自動で削除されます。

# ER図
![ordersystem](https://user-images.githubusercontent.com/60236933/93491664-edbe8580-f944-11ea-84de-881ac605df3e.jpg)

# テーブル設計

## users テーブル

| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| store_name   | string | null: false |
| store_number | string | null: false |
| email        | string | null: false |
| password     | string | null: false |

### Association

- has_many :items
- has_many :inventories
- has_many :sales
- has_many :comments
- has_many :deliveries
- has_many :specials

## items テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false                    |
| margin  | integer    | null: false                    |
| user_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :inventories

## inventories テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| order   | integer    |                                |
| use     | integer    |                                |
| stock   | integer    |                                |
| date    | date       | null: false                    |
| item_id | references | null: false, foreign_key: true |
| user_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## sales テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| plan    | integer    | null: false                    |
| actual  | integer    |                                |
| date    | date       | null: false                    |
| user_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| text    | text       | null: false                    |
| date    | date       | null: false                    |
| user_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## deliveries テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| day_of_week | string     |                                |
| check       | boolean    | null: false, default: false    |
| user_id     | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## specials テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| date    | date       | null: false                    |
| user_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
