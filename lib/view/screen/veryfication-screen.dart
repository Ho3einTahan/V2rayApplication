import 'package:flutter/material.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class VeryficationScreen extends StatefulWidget {
  @override
  _VeryficationScreenState createState() => _VeryficationScreenState();
}

class _VeryficationScreenState extends State<VeryficationScreen> {
  int _otpCodeLength = 4;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController otpController = new TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    _startListeningSms();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        otpController.text = _otpCode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldPin(
                    textController: otpController,
                    autoFocus: true,
                    codeLength: _otpCodeLength,
                    alignment: MainAxisAlignment.center,
                    defaultBoxSize: 55,
                    margin: 10,
                    selectedBoxSize: 55,
                    textStyle: const TextStyle(fontSize: 16),
                    defaultDecoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15.0),
                    ).copyWith(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.6))),
                    selectedDecoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onChange: (code) {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
