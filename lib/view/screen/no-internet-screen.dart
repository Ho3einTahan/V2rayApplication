import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:v2ray/view/screen/login-screen.dart';

import '../../core/class/MyPrefrences.dart';
import '../../core/class/get-imei.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000046),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                'لطفا اتصال خود را به اینترنت چک کنید!',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: context.textTheme.bodyLarge!.copyWith(fontSize: 23, fontWeight: FontWeight.w700),
              ),
            ),
            Center(child: Lottie.asset('images/no-internet.json', width: 370, height: 300)),
            Center(
                child: TextButton(
                    onPressed: () async {
                      final userPhone = await MyPreferences.getUserPhoneNumber() ?? '';
                      final userPassword = await MyPreferences.getUserPassword() ?? '';
                      final macAddress = await ImeiManager.getDeviceIMEINumber();
                      Get.offAll(LoginScreen(userPhone: userPhone, userPassword: userPassword, macAddress: macAddress));
                    },
                    child: Text('تلاش مجدد', style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 28)))),
          ],
        ),
      ),
    );
  }
}
