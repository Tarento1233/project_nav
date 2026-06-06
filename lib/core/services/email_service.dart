import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  // === CẤU HÌNH GỬI EMAIL ===
  // Người dùng thay đổi thông tin này để gửi OTP thật
  static const String _senderEmail = 'teoo12333@gmail.com'; // Ví dụ: shopoutletfashion@gmail.com
  static const String _appPassword = 'lnayuogxqqpungmq'; // Mật khẩu ứng dụng Gmail (16 ký tự)

  static bool get isConfigured =>
      _senderEmail.isNotEmpty &&
      _senderEmail != 'your_email@gmail.com' &&
      _appPassword.isNotEmpty &&
      _appPassword != 'your_app_password';

  /// Gửi mã OTP về email của người nhận
  static Future<bool> sendOTP(String recipientEmail, String otpCode) async {
    if (!isConfigured) {
      print("EMAIL SERVICE: Chưa cấu hình thông tin Email gửi đi!");
      return false;
    }

    final smtpServer = gmail(_senderEmail, _appPassword);

    final message = Message()
      ..from = Address(_senderEmail, 'Outlet Fashion')
      ..recipients.add(recipientEmail)
      ..subject = 'Mã xác thực OTP đăng ký tài khoản Outlet Fashion'
      ..html = '''
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
          <div style="background-color: #2F80ED; padding: 20px; text-align: center; color: white;">
            <h1 style="margin: 0; font-size: 24px;">Outlet Fashion</h1>
            <p style="margin: 5px 0 0 0; font-size: 14px;">Luxury Outlet & Consignment</p>
          </div>
          <div style="padding: 30px; line-height: 1.6; color: #333333;">
            <p style="font-size: 16px; margin-top: 0;">Xin chào,</p>
            <p style="font-size: 16px;">Bạn đang thực hiện đăng ký tài khoản mới trên ứng dụng <strong>Outlet Fashion</strong>.</p>
            <p style="font-size: 16px;">Vui lòng sử dụng mã OTP dưới đây để xác thực tài khoản của bạn:</p>
            <div style="text-align: center; margin: 30px 0;">
              <span style="font-size: 32px; font-weight: bold; color: #2F80ED; letter-spacing: 5px; background-color: #f2f7fe; padding: 10px 25px; border-radius: 5px; border: 1px dashed #2F80ED;">$otpCode</span>
            </div>
            <p style="font-size: 14px; color: #E05638; font-weight: bold; margin-bottom: 20px;">Lưu ý: Mã này chỉ có hiệu lực trong vòng 5 phút và không được chia sẻ với bất kỳ ai.</p>
            <p style="font-size: 16px; border-top: 1px solid #eeeeee; padding-top: 20px; margin-bottom: 0;">Trân trọng,<br/>Đội ngũ Outlet Fashion</p>
          </div>
        </div>
      ''';

    try {
      await send(message, smtpServer);
      print('OTP sent successfully to $recipientEmail');
      return true;
    } catch (e) {
      print('SMTP send error: $e');
      return false;
    }
  }

  /// Gửi mã OTP khôi phục mật khẩu
  static Future<bool> sendForgotPasswordOTP(String recipientEmail, String otpCode) async {
    if (!isConfigured) {
      print("EMAIL SERVICE: Chưa cấu hình thông tin Email gửi đi!");
      return false;
    }

    final smtpServer = gmail(_senderEmail, _appPassword);

    final message = Message()
      ..from = Address(_senderEmail, 'Outlet Fashion')
      ..recipients.add(recipientEmail)
      ..subject = 'Mã xác thực OTP khôi phục mật khẩu Outlet Fashion'
      ..html = '''
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
          <div style="background-color: #E05638; padding: 20px; text-align: center; color: white;">
            <h1 style="margin: 0; font-size: 24px;">Outlet Fashion</h1>
            <p style="margin: 5px 0 0 0; font-size: 14px;">Luxury Outlet & Consignment</p>
          </div>
          <div style="padding: 30px; line-height: 1.6; color: #333333;">
            <p style="font-size: 16px; margin-top: 0;">Xin chào,</p>
            <p style="font-size: 16px;">Bạn đang thực hiện yêu cầu khôi phục mật khẩu trên ứng dụng <strong>Outlet Fashion</strong>.</p>
            <p style="font-size: 16px;">Vui lòng sử dụng mã OTP dưới đây để tiến hành thiết lập mật khẩu mới:</p>
            <div style="text-align: center; margin: 30px 0;">
              <span style="font-size: 32px; font-weight: bold; color: #E05638; letter-spacing: 5px; background-color: #fff5f2; padding: 10px 25px; border-radius: 5px; border: 1px dashed #E05638;">$otpCode</span>
            </div>
            <p style="font-size: 14px; color: #E05638; font-weight: bold; margin-bottom: 20px;">Lưu ý: Mã này chỉ có hiệu lực trong vòng 5 phút và không được chia sẻ với bất kỳ ai.</p>
            <p style="font-size: 16px; border-top: 1px solid #eeeeee; padding-top: 20px; margin-bottom: 0;">Trân trọng,<br/>Đội ngũ Outlet Fashion</p>
          </div>
        </div>
      ''';

    try {
      await send(message, smtpServer);
      print('Forgot password OTP sent successfully to $recipientEmail');
      return true;
    } catch (e) {
      print('SMTP send error: $e');
      return false;
    }
  }

  /// Sinh mã OTP 6 chữ số ngẫu nhiên
  static String generateOTP() {
    final random = Random();
    String otp = '';
    for (int i = 0; i < 6; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }
}
