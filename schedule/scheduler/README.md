# scheduler — CP-SAT 排班引擎（experimental）

平行於舊 `mainpage/functions.py` 排班邏輯，**不取代**。

## 目標

用 Google OR-Tools CP-SAT 重寫排班生成，跟舊 randomized retry 同條件並排比較，
驗證新版產出符合既有 `api/check.py` 法規檢驗，再決定是否切換。

## 架構（plan）

```
scheduler/
├── data.py          # 純 dataclass（SchedulingProblem 等），不依賴 Django
├── loaders.py       # DB → SchedulingProblem（唯一 ORM 接觸點）
├── model.py         # (TODO step 2) CP-SAT 變數 + 約束
├── solver.py        # (TODO step 3) 求解 + 解析回 PreResult-shape 結果
├── writer.py        # (TODO step 4) 結果寫回 PreResult（實驗 flag）
└── management/commands/
    ├── cpsat_load.py    # 載入問題 + 印摘要（檢查 loader）
    ├── cpsat_solve.py   # (TODO) 載入 + 求解 + 印解
    └── cpsat_compare.py # (TODO) 跟舊版同條件對比
```

## 進度

- [x] **step 1**：app 骨架 + dataclass + loader + 載入命令
- [ ] step 2：CP-SAT model（每天每班需求 / 每人每天一狀態 / 預排假/班）
- [ ] step 3：加入軟硬約束（連續工作上限、間隔 11h、孕婦不夜、shift type cycle）
- [ ] step 4：寫回 PreResult（實驗 flag）+ 跟舊版比對 management command

## 用法（step 1）

```bash
docker compose exec app python3 manage.py cpsat_load \
    --department 4 --year 2020 --month 9

# 拿完整 dump 對照
docker compose exec app python3 manage.py cpsat_load \
    --department 4 --year 2020 --month 9 --format json
```

## 設計原則

1. **完全不動舊 code**。`mainpage/functions.py` / `api/check.py` 保持原狀。
2. **dataclass 不依賴 Django**。`data.py` 應該可以在沒 DB 的環境用假資料跑。
3. **演算法跟資料解耦**。loader 只進不出，model/solver 不碰 ORM。
4. **可驗證**。新版產出必須通過 `api/check.py` 既有檢驗才算合格。
