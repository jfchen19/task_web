# README

## 簡易任務管理系統
* 可新增自己的任務
* 可設定任務的開始及結束時間
* 任務列表，並可依建立時間及結束時間進行排序
* 自由切換全站中英文
* 可設定任務狀態（待處理、進行中、已完成）
* 網站部署於[Heroku](http://tasksweb.herokuapp.com/)
* RSpec: Feature test and Model test
* Bootstrap 4.6

### 開發環境：
  * GitHub
  * Ruby: 2.7.2
  * Rails: 6.1.3

### Table schema
  * tasks

| Column     | Data Type |
| --------   | --------  |
| id         | integer   |
| title      | string    |
| subject    | string    |
| start_time | datetime  |
| end_time   | datetime  |
