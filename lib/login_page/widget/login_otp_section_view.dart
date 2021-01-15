import 'package:flutter/material.dart';

class LoginOTPSectionView extends StatelessWidget {
  final Function(String ref, String code) onVerifyOTP;

  const LoginOTPSectionView({
    Key key,
    @required this.onVerifyOTP,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: "Type in your text",
                fillColor: Colors.white70),
          ),
          ElevatedButton(
            child: Text('Send OTP'),
            onPressed: () => onVerifyOTP('', ''),
          ),
        ],
      ),
    );
  }
}
