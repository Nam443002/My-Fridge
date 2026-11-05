# my-fridge (SmartMeal AI)

Hệ thống ứng dụng Android quản lý nguyên liệu theo lô, cảnh báo hạn sử dụng
và gợi ý món ăn theo quy mô gia đình kết hợp BMI — ứng dụng Trí tuệ Nhân tạo.

## Monorepo Stack
| Layer    | Technology                                      | Directory             |
|----------|-------------------------------------------------|-----------------------|
| Mobile   | React Native + TypeScript (APK/AAB)             | `mobile-rn-ts/`       |
| Backend  | NestJS + TypeScript, Clean Architecture         | `backend-node-ts/`    |
| AI       | FastAPI (stateless) + YOLOv8 + Sentence-BERT    | `ai-service-fastapi/` |
| ML Train | YOLO Nano training & evaluation pipeline        | `ml/`                 |
| Infra    | PostgreSQL(pgvector), Redis, MinIO, Nginx        | `infra/`              |
