# README

## 簡易任務管理系統
* 可新增自己的任務
* 可設定任務的開始、結束時間以及優先順序並排序
* 可設定任務狀態（待處理、進行中、已完成）並以任務狀態搜尋
* 任務可以設定多個標籤，並以標籤進行搜尋
* 自由切換全站中英文
* 會員登入功能，未登入時無法進入任務頁面，且使用者僅能看到自己的任務
* 擁有管理員權限的使用者可以存取使用者管理頁面
* 網站部署於[Heroku](http://taskwebsite.herokuapp.com/)
* RSpec: Feature test and Model test

### 開發環境：
  * GitHub
  * Ruby: 2.7.2
  * Rails: 6.1.3
  * Bootstrap 4.6

### Table schema
  * Users

  | Column     | Data Type |
  | --------   | --------  |
  | email      | string    |
  | password   | string    |
  | nickname   | string    |
  | admin      | boolean   |
  | create_at  | datetime  |
  | update_at  | datetime  |

  * Tasks

  | Column     | Data Type |
  | --------   | --------  |
  | id         | integer   |
  | title      | string    |
  | subject    | string    |
  | state      | string    |
  | priority   | integer   |
  | start_time | datetime  |
  | end_time   | datetime  |
  | create_at  | datetime  |
  | update_at  | datetime  |

  * Tags

  | Column     | Data Type |
  | --------   | --------  |
  | name       | string    |
  | create_at  | datetime  |
  | update_at  | datetime  |

  * Taggings

  | Column     | Data Type |
  | --------   | --------  |
  | tag_id     | bigint    |
  | task_id    | bigint    |
  | create_at  | datetime  |
  | update_at  | datetime  |
