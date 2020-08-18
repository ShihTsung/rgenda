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

docker 指令：
    1.重開程式： docker-compose restart
    2.啟動： docker-compose up
    3.啟動並重新建立容器： docker-compose up --build
    4.關閉：docker-compose down

網址列指令：
    1. /init: 資料庫初始化
    2. /results/create_result/department_id/YYYY-MM-DD/YYYY-MM-DD: 建立從日期一到日期二的排班結果