# Dự án Smartfarm-system
## Hướng dẫn chạy scripts
```
.\auto_report.ps1

```
## Check list kiểm tra thiết bị 
- [x]Khởi tạo căn cứ số 
- [x]Robot lọc log tự động 
- [x]Đối soát tài nguyên 
## Bảng thông số phần cứng 
|Tên thiết bị|Đơn giá |loại storage|
|-|-|-|
|Raspberry Pi 4 Model B|1.450.000|SSD|
|Intel NUC i3|6.200.000|SSD|
|Orange Pi 5|2.300.000|SSD|

## Phân tích hệ thống 

1. Input – Process – Output của chức năng lọc log
Thành phần	Nội dung
Input	File log-he-thong.log: các dòng log thô của hệ thống (thời gian, mức độ như INFO/WARNING/ERROR/CRITICAL, trạm, nội dung). Có thể thêm từ khóa lọc: ERROR, CRITICAL.
Process	Script auto_report.ps1 đọc log bằng Get-Content, dùng pipeline | chuyển sang Select-String để giữ lại các dòng chứa ERROR hoặc CRITICAL, đếm số dòng lọc được, lấy ngày giờ bằng Get-Date, rồi ghi nối bằng >>.
Output	File backup/bao-cao-su-co.txt gồm: tiêu đề báo cáo, ngày giờ lập báo cáo, danh sách các dòng sự cố đã lọc và tổng số sự cố.

Có thể viết gọn theo sơ đồ:

log-he-thong.log  →  Lọc ERROR|CRITICAL + đếm + thêm ngày giờ  →  bao-cao-su-co.txt
     (Input)                       (Process)                          (Output)
2. Phân loại DIKW
Phát biểu	Tầng	Lý do
(b) “2026-10-12 08:15:01 [ERROR] sensor-03 Connection TIMEOUT after 30s”	Data (Dữ liệu)	Là bản ghi thô, rời rạc, chưa được xử lý hay giải thích. Đây chính là một dòng trong file log.
(c) “Hôm nay hệ thống ghi nhận 8 sự cố, trong đó 4 sự cố đến từ trạm sensor-03.”	Information (Thông tin)	Dữ liệu đã được lọc, đếm, tổng hợp và gắn ngữ cảnh (hôm nay, bao nhiêu sự cố, trạm nào). Trả lời được câu hỏi “cái gì, bao nhiêu”.
(d) “Trạm sensor-03 hay mất kết nối vào buổi chiều do sóng yếu, nên cần lắp thêm anten.”	Knowledge (Tri thức)	Rút ra quy luật và nguyên nhân từ nhiều thông tin (hay xảy ra lúc nào, vì sao), từ đó biết cách xử lý. Trả lời được câu hỏi “như thế nào, tại sao”.
(a) “Quyết định thay modem trạm sensor-03 trước thứ Sáu.”	Wisdom (Trí tuệ)	Là quyết định hành động, cân nhắc mức độ ưu tiên và thời hạn dựa trên tri thức. Trả lời câu hỏi “nên làm gì”.

Thứ tự từ thấp đến cao: (b) Data → (c) Information → (d) Knowledge → (a) Wisdom.

Liên hệ với chức năng lọc log

Chức năng auto_report.ps1 của bạn chủ yếu biến Data (b) thành Information (c): lọc các dòng lỗi và đếm tổng số sự cố. Việc tìm ra nguyên nhân (d) và ra quyết định (a) vẫn cần con người phân tích báo cáo.




