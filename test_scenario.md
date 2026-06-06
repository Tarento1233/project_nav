# KỊCH BẢN KIỂM THỬ TOÀN BỘ ỨNG DỤNG (8 BƯỚC)

Tài liệu này hướng dẫn chi tiết 8 bước để kiểm thử toàn bộ luồng chức năng của ứng dụng **Outlet Fashion** (bao gồm luồng người dùng, ký gửi, mua bán, chia tiền tự động, rút tiền và tính năng quên mật khẩu/OTP mới).

---

### BƯỚC 1: Đăng ký tài khoản người dùng mới (Xác thực OTP)
1. Mở ứng dụng, tại màn hình **Đăng nhập**, bấm **Đăng ký**.
2. Nhập các thông tin thử nghiệm:
   - **Số điện thoại**: Phải nhập đủ từ 10 đến 11 chữ số (VD: `0987654321`).
   - **Email**: Nhập email thật của bạn (để nhận mã OTP thật gửi về hòm thư).
   - **Mật khẩu & Nhập lại mật khẩu**: Điền trùng khớp.
3. Tích chọn đồng ý điều khoản dịch vụ (quy định mức phí hoa hồng ký gửi tối đa 20%).
4. Bấm **Tạo tài khoản**:
   - Hệ thống sẽ gửi một mã OTP thật gồm 6 chữ số về email của bạn và tự động chuyển qua màn hình nhập OTP.
   - *Lưu ý*: Nếu EmailService hoạt động ở chế độ giả lập (do chưa cấu hình App Password), một mã OTP test sẽ hiển thị ở ô thông báo bên dưới để bạn test nhanh.
5. Kiểm tra **Hộp thư đến** hoặc thư mục **Thư rác (Spam)** trong email của bạn để lấy mã OTP. Điền mã vào ô nhập và bấm **Xác thực & Đăng ký** để hoàn thành tạo tài khoản.

---

### BƯỚC 2: Kiểm thử Quên mật khẩu & Đặt lại mật khẩu (Trong App)
1. Tại màn hình **Đăng nhập**, chọn **Quên mật khẩu**.
2. Nhập một email chưa đăng ký -> Hệ thống phải báo lỗi *"Email này chưa được đăng ký tài khoản!"*.
3. Nhập Email thật bạn vừa đăng ký ở Bước 1 và nhấn **Gửi email xác nhận**:
   - Hệ thống sẽ gửi mã OTP khôi phục mật khẩu về email của bạn và chuyển sang màn hình **Xác thực OTP**.
4. Lấy mã OTP trong hòm thư, điền vào app và bấm **Xác thực OTP**.
5. Màn hình **Đặt lại mật khẩu** hiện ra:
   - Điền mật khẩu mới ngắn hơn 6 ký tự hoặc nhập lại không khớp -> Hệ thống báo lỗi tương ứng.
   - Nhập mật khẩu mới hợp lệ (VD: `password456`) và trùng khớp ở cả 2 ô -> Bấm **Đặt lại mật khẩu**.
6. Hệ thống đưa bạn quay lại màn hình Đăng nhập. Hãy thử đăng nhập bằng email với mật khẩu mới để kiểm tra xem mật khẩu đã được cập nhật thành công.

---

### BƯỚC 3: Thiết lập Hoa hồng mặc định (Vai trò: Admin)
1. Đăng xuất tài khoản người dùng hiện tại.
2. Đăng nhập bằng tài khoản Admin hệ thống:
   - **Email**: `admin@outlet.com`
   - **Mật khẩu**: `password123`
3. Màn hình tự động chuyển sang trang quản lý **Admin Dashboard**.
4. Truy cập vào mục **Cài đặt hệ thống** (hoặc biểu tượng Bánh răng/Cài đặt).
5. Thiết lập tỷ lệ hoa hồng mặc định của shop (Ví dụ sửa từ `10%` thành `12%`). Bấm **Cập nhật**.
6. Lúc này, bất kỳ sản phẩm ký gửi mới nào gửi lên sau đó sẽ tự động áp dụng mức hoa hồng mặc định này ở màn hình duyệt của Admin.

---

### BƯỚC 4: Tạo yêu cầu ký gửi sản phẩm (Vai trò: Người ký gửi)
1. Đăng xuất tài khoản Admin. Đăng nhập lại bằng tài khoản người dùng bạn tạo ở Bước 1.
2. Vào tab **Tài khoản** (Profile) -> Chọn mục **Ký gửi của tôi**.
3. Bấm biểu tượng dấu **+** ở góc trên bên phải để tạo yêu cầu ký gửi mới.
4. Điền các thông tin sản phẩm muốn ký gửi:
   - **Tên sản phẩm**: Ví dụ: `Túi xách Balenciaga`
   - **Số lượng tồn kho**: Nhập số lượng lớn để test trừ kho (Ví dụ: `100`).
   - **Giá mong muốn**: Ví dụ: `1.000.000đ`.
   - Các thông tin khác: Chọn ảnh từ thư viện, nhập Thương hiệu, Danh mục, Kích thước, Tình trạng.
5. Bấm **Gửi yêu cầu**. Yêu cầu ký gửi mới tạo sẽ hiển thị trong danh sách ở trạng thái **ĐANG CHỜ DUYỆT**.

---

### BƯỚC 5: Duyệt / Từ chối ký gửi & Kiểm soát hoa hồng (Vai trò: Admin)
1. Đăng xuất người dùng. Đăng nhập lại tài khoản Admin (`admin@outlet.com` / `password123`).
2. Vào tab **Ký gửi** (biểu tượng Hộp sản phẩm) dưới thanh điều hướng Admin. Tìm sản phẩm vừa gửi ở Bước 4.
3. **Test luồng Từ chối (Nếu cần)**:
   - Bấm **Từ chối ký gửi**, nhập lý do từ chối (VD: "Sản phẩm không rõ nguồn gốc").
   - Đăng nhập lại tài khoản người dùng -> Vào **Ký gửi của tôi** sẽ thấy trạng thái đổi thành **BỊ TỪ CHỐI**. Người dùng có thể nhấn **Chỉnh sửa**, cập nhật thông tin/ảnh mới và bấm **Gửi lại** (sản phẩm chuyển về trạng thái **ĐANG CHỜ DUYỆT** để Admin duyệt lại).
4. **Test luồng Duyệt ký gửi**:
   - Admin vào chi tiết sản phẩm chờ duyệt.
   - Nhập **Giá duyệt bán** (Ví dụ: `1.000.000đ`).
   - Nhập **Tỷ lệ hoa hồng**: Thử nhập mức hoa hồng lớn hơn `20%` -> Hệ thống sẽ hiển thị cảnh báo lỗi *"Tỷ lệ hoa hồng tối đa là 20%!"* và không cho phép duyệt.
   - Nhập tỷ lệ hoa hồng hợp lệ (Ví dụ: `10%`).
5. Bấm **Xác nhận duyệt** -> Sản phẩm ký gửi sẽ tự động chuyển sang trạng thái **ĐANG BÁN** và lập tức hiển thị công khai trên giao diện trang chủ của Shop.

---

### BƯỚC 6: Khách mua hàng & Trừ kho thông minh (Vai trò: Khách hàng)
1. Đăng xuất Admin. Đăng nhập bằng tài khoản người dùng bất kỳ (Ví dụ: tài khoản tạo ở Bước 1 hoặc tài khoản mẫu `vanga@gmail.com`).
2. Tại màn hình **Trang chủ** (Home), bạn sẽ thấy sản phẩm ký gửi `Túi xách Balenciaga` đang được đăng bán.
3. Bấm vào sản phẩm, chọn kích cỡ (Size), chọn số lượng mua (Ví dụ mua `2` cái) và bấm **Thêm vào giỏ hàng**.
4. Truy cập **Giỏ hàng**, chọn **Thanh toán**. Điền địa chỉ nhận hàng và chọn phương thức thanh toán, bấm **Đặt hàng**.
5. Đơn hàng mới sẽ được tạo ở trạng thái **ĐANG GIAO**.
6. **Kiểm tra kho hàng**: Quay lại trang chi tiết sản phẩm trên Shop, số lượng tồn kho phải giảm đi chính xác (từ `100` xuống `98` cái) và trạng thái sản phẩm trên shop vẫn giữ là **ĐANG BÁN** (chỉ chuyển sang "Hết hàng/Đã bán" khi số lượng tồn kho giảm về `0`).

---

### BƯỚC 7: Hoàn thành đơn hàng & Chia tiền tự động (Vai trò: Admin)
1. Đăng xuất người dùng. Đăng nhập lại tài khoản Admin (`admin@outlet.com` / `password123`).
2. Vào tab **Đơn hàng** (biểu tượng Giỏ hàng) dưới thanh điều hướng Admin.
3. Chọn đơn hàng vừa được mua ở Bước 6, bấm vào xem chi tiết và chọn **Xác nhận hoàn thành** (Đơn hàng chuyển sang trạng thái **HOÀN THÀNH**).
4. **Hệ thống tự động thực hiện**:
   - **Chia tiền tự động**: 
     - Tổng tiền đơn hàng của sản phẩm ký gửi: $1.000.000đ \times 2 = 2.000.000đ$.
     - Hoa hồng của Shop ($10\%$): $200.000đ$ (cộng vào Doanh thu của Shop).
     - Tiền của người ký gửi ($90\%$): $1.800.000đ$ (cộng thẳng vào số dư ví của người ký gửi).
   - **Ghi nhận lịch sử giao dịch**: Tạo giao dịch ví cộng tiền cho người ký gửi.
   - **Gửi thông báo**: Gửi thông báo biến động số dư và hoàn thành đơn hàng cho người ký gửi.

---

### BƯỚC 8: Rút tiền và Phê duyệt rút tiền (Người bán & Admin)
1. Đăng xuất Admin. Đăng nhập lại tài khoản người ký gửi ở Bước 4.
2. Vào tab **Tài khoản** -> Chọn **Ví của tôi**. Bạn sẽ thấy:
   - **Số dư khả dụng** hiển thị đúng số tiền đã trừ hoa hồng (`+1.800.000đ`).
   - Danh sách **Lịch sử giao dịch** hiển thị dòng tiền cộng màu xanh lá.
   - Hộp thư **Thông báo** có tin nhắn báo tiền về.
3. Bấm nút **Rút tiền**:
   - Nhập số tiền muốn rút (VD: `500.000đ`).
   - Nhập thông tin ngân hàng nhận tiền (Tên ngân hàng, Số tài khoản, Tên chủ tài khoản).
   - Bấm **Xác nhận**. Số tiền khả dụng sẽ tạm trừ đi và chuyển sang trạng thái **Đang chờ xử lý**.
4. Đăng xuất người dùng. Đăng nhập lại tài khoản Admin (`admin@outlet.com` / `password123`).
5. Tại màn hình chính Admin Dashboard, mục **Yêu cầu rút tiền chờ xử lý** sẽ hiển thị yêu cầu rút tiền của tài khoản trên.
6. Admin bấm **Xác nhận thanh toán** để phê duyệt -> Giao dịch rút tiền chuyển sang trạng thái thành công, tiền được hoàn tất chuyển khoản cho người ký gửi.
