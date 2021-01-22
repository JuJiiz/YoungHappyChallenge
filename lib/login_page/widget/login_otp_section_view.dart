import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class LoginOTPSectionView extends StatefulWidget {
  final Function(String code) onVerifyOTP;
  final Function() onResendOTP;

  const LoginOTPSectionView({
    Key key,
    @required this.onVerifyOTP,
    @required this.onResendOTP,
  }) : super(key: key);

  @override
  _LoginOTPSectionViewState createState() => _LoginOTPSectionViewState();
}

class _LoginOTPSectionViewState extends State<LoginOTPSectionView> {
  final _otpCode = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _otpCode.close();
    super.dispose();
  }

  _onVerifyOTP() async {
    String code = _otpCode.stream.value;
    widget.onVerifyOTP(code);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      constraints: BoxConstraints(maxWidth: 320),
      child: Column(
        children: [
          Container(
            height: 50,
            child: Text('รหัส OTP ยืนยัน จะถูกส่งไปที่ข้อความของท่าน'),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: TextField(
              onChanged: _otpCode.sink.add,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.singleLineFormatter
              ],
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "กรอกรหัส OTP ที่ได้รับ",
                  fillColor: Colors.white70),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            child: Text('ยืนยัน OTP'),
            onPressed: () => _onVerifyOTP(),
          ),
          SizedBox(height: 8.0),
          FlatButton(
            child: Text('ส่ง OTP อีกครั้ง'),
            onPressed: widget.onResendOTP,
          ),
        ],
      ),
    );
  }
}
