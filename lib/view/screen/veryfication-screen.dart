import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sms_consent_for_otp_autofill/sms_consent_for_otp_autofill.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late SmsConsentForOtpAutofill smsConsentForOtpAutoFill;
  OtpFieldController otpController = OtpFieldController();
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    // Initialize smsConsentForOtpAutoFill
    smsConsentForOtpAutoFill = SmsConsentForOtpAutofill(
      phoneNumberListener: (number) {
        setState(() {
          phoneNumber = number;
        });
        print("Received phone number: $number");
      },
      smsListener: (otpCode) {
        otpController.clear();
        String? extractedCode = getCode(otpCode);
        if (extractedCode != null) {
          List<String> codeDigits = extractedCode.split('');
          otpController.set(codeDigits);
        } else {
          // Handle case where OTP extraction failed
          print("Failed to extract OTP from SMS: $otpCode");
        }
      },
    );
    // Request SMS consent
    smsConsentForOtpAutoFill.requestSms();
  }

  @override
  void dispose() {
    smsConsentForOtpAutoFill.dispose();
    super.dispose();
  }

  String? getCode(String? sms) {
    if (sms != null) {
      final codeRegex = RegExp(r'\b\d{5}\b'); // Assuming OTP is 5 digits
      final match = codeRegex.firstMatch(sms);
      if (match != null) {
        return match.group(0);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Center(
              child: Text(
                "code was sent to the 09905891724",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            OTPTextField(
              keyboardType: TextInputType.phone,
              controller: otpController,
              length: 5,
              width: double.infinity,
              fieldWidth: 50,
              style: const TextStyle(fontSize: 17),
              otpFieldStyle: OtpFieldStyle(
                borderColor: Colors.white,
                enabledBorderColor: Colors.white,
                focusBorderColor: Colors.white,
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                smsConsentForOtpAutoFill.requestSms();
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {},
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
