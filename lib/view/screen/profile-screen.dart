import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:v2ray/core/class/MyPrefrences.dart';

import '../../core/class/get-imei.dart';
import '../../core/function/open-telegram-support.dart';
import '../widget/custom-divider.dart';
import '../widget/header-appbar.dart';
import 'login-screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String userPhone = '';
  String startServiceDate = '';
  String endServiceDate = '';

  @override
  void initState() {
    super.initState();
    initialUserInfo();
  }

  Future<void> initialUserInfo() async {
    startServiceDate = await MyPreferences.getStartServiceDate() ?? '';
    endServiceDate = await MyPreferences.getEndServiceDate() ?? '';
    userName = await MyPreferences.getUserName() ?? '';
    userPhone = await MyPreferences.getUserPhoneNumber() ?? '';
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000046),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 28),
            buildHeader(userName, 'profile'),
            const SizedBox(height: 50),
            Row(
              children: [
                customDivider(),
                Text('اطلاعات کاربر', style: context.textTheme.titleLarge!.copyWith(fontSize: 14)),
                customDivider(),
              ],
            ),
            const SizedBox(height: 72),
            _buildServiceInfo(startServiceDate, endServiceDate, userName),
          ],
        ),
      ),
    );
  }

  final textStyle = Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.white);

  Widget _buildServiceInfo(String startServiceDate, String endServiceDate, String userName) {
    return Container(
      width: 350,
      height: 380,
      decoration: BoxDecoration(
        color: const Color(0xff1D192B),
        border: const GradientBoxBorder(
          gradient: LinearGradient(begin: Alignment.topRight, colors: [Color(0xff23C95B), Color(0xff6F34FE)]),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('تاریخ شروع سرویس :', style: textStyle),
                Text(startServiceDate, style: textStyle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('تاریخ اتمام سرویس :', style: textStyle),
                Text(endServiceDate, style: textStyle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('شماره تلفن : ', style: textStyle),
                Text(userPhone, style: textStyle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUpdateSubscriptionButton(),
                _buildLogOutButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogOutButton() {
    return GestureDetector(
      onTap: () async {
        MyPreferences.setIsUserLoggedIn(isLoggedIn: false);
        MyPreferences.setUserToken(token: '');
        final userPhone = await MyPreferences.getUserPhoneNumber() ?? '';
        final userPassword = await MyPreferences.getUserPassword() ?? '';
        final macAddress = await ImeiManager.getDeviceIMEINumber();
        Get.offAll(LoginScreen(userPhone: userPhone, userPassword: userPassword, macAddress: macAddress));
      },
      child: Container(
        width: 150,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffFF0000), width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
            child: Text(
          'خروج از حساب',
          style: Get.context!.textTheme.titleLarge!.copyWith(fontSize: 18),
        )),
      ),
    );
  }

  Widget _buildUpdateSubscriptionButton() {
    return GestureDetector(
      onTap: openTelegram,
      child: Container(
        width: 150,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffFFffff), width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
            child: Text(
          'بروزرسانی اشتراک',
          style: Get.context!.textTheme.titleLarge!.copyWith(fontSize: 18),
        )),
      ),
    );
  }
}
