# Viet Quote & Joke API

## Giới thiệu
API cung cấp câu trích dẫn và câu chuyện cười bằng tiếng Việt.
## Các Endpoint
1. **/** (index):
- Hiện cách dùng API
2. **/api/quote** (Quote API):
- Lấy quote từ Zen Quote API,dịch sang ngôn ngữ (Xác định trong parameter)
3. **/api/joke** (Joke API):
- Tương tự như Quote API
## Cài đặt
1. clone repo về
### Mac, Android và Linux
```bash
chmod +x setup.sh
./setup.sh
```
### Windows
```batch
setup.bat
```
**LƯU Ý: Linux thì dùng ssh để open public cho API**
**	Còn Win 10/11: ssh cài sẵn còn 7/8 thì cài Putty**
## Chạy server public
- Lệnh Linux / mac / android
```bash
cd vn-quotes-api
ssh -R <tên miền phụ>.serveo.net:80:localhost:5000 serveo.net
```
- config Putty
Sau khi cài đặt, mở PuTTY.


### Bước 1: Thiết lập kết nối SSH tới Serveo

1. Mở PuTTY và bạn sẽ thấy cửa sổ cấu hình chính.


2. Trong mục Session, ở phần Host Name (or IP address), nhập serveo.net.


3. Chọn giao thức SSH và để cổng là 22 (mặc định cho SSH).



### Bước 2: Cấu hình chuyển tiếp cổng

1. Trong danh sách Category bên trái, mở rộng Connection -> SSH và chọn Tunnels.


2. Trong mục Add new forwarded port:

Ở trường Source Port, nhập cổng mà bạn muốn chuyển tiếp từ máy cục bộ. Ví dụ, nếu ứng dụng cục bộ của bạn đang chạy trên cổng 3000, bạn nhập 3000.

Ở trường Destination, nhập localhost:3000 (hoặc cổng mà ứng dụng của bạn đang chạy cục bộ).



3. Nhấn Add để thêm quy tắc chuyển tiếp cổng.

Bạn sẽ thấy quy tắc này xuất hiện trong danh sách Forwarded ports.



4. Trở lại Session và đặt tên cho cấu hình này trong mục Saved Sessions (ví dụ: "Serveo SSH") và nhấn Save để lưu lại.



### Bước 3: Kết nối tới Serveo

1. Quay lại tab Session trong PuTTY, nhấn Open để kết nối với serveo.net.


2. Bạn sẽ được yêu cầu nhập tên người dùng:

Bạn chỉ cần nhấn Enter (bỏ qua yêu cầu này vì Serveo không yêu cầu tên đăng nhập cụ thể).




### Bước 4: Sử dụng tên miền tùy chỉnh (Optional)

Nếu bạn muốn dùng tên miền phụ tùy chỉnh cho ứng dụng của mình, bạn có thể thêm vào trong dòng lệnh SSH.

Quay lại bước 2, nhưng lần này trong mục Host Name (or IP address), bạn có thể nhập:


serveo.net -R yourname.serveo.net:80:localhost:3000

Thay yourname bằng tên bạn mong muốn. Sau khi cấu hình và kết nối, bạn sẽ có một tên miền dạng https://yourname.serveo.net có thể truy cập công khai.

### Bước 6: Kết thúc kết nối

Để ngắt kết nối, chỉ cần đóng cửa sổ PuTTY hoặc nhấn Ctrl + C nếu đang trong cửa sổ lệnh.
## API dùng thử
link: https://vietquoteandjoke.serveo.net/


# Dùng script vui nha , nếu có dùng cho mục đích thương mại
# (mod script) thì @ username tui vào và
# để link github của tui là oke!

