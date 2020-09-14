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
