# skuld project

```
git clone http://192.168.1.101:3000/redfalcon/skuld.git

docker-compose up

add a .env file:

MYSQL_ROOT_PASSWORD=redfalcon
MYSQL_DATABASE=DB
MYSQL_USER=circlepen
MYSQL_PASSWORD=redfalcon

```

第一次build mysql 會比較晚起來，所以會出錯  
control + C 跳出，再重新 docker-compose up 就行了  
或是可以先啟動 docker-compose up db  
再啟動 web  


網址列輸入 /init 可以將資料庫資料初始化

## 目錄說明

| 資料夾       | 說明           |
| ----------- | -------------- |
| account     | 帳號，部門      |
| api         | API相關        |
| date        | 日期管理        |
| demand      | 人力需求        |
| mainpage    | 首頁           |
| reservation | 預排假班        |
| scripts     | 額外函式        |
| schedule    | 設定檔，主目錄   |
| shift       | 班別管理        |
| static      | 靜態檔案        |
| station     | 工作站管理      |
| template    | 前端頁面        |

