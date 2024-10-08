import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:v2ray/bloc/auth/auth_bloc.dart';

import '../../core/function/open-telegram-support.dart';
import '../widget/custom-divider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, this.userPhone, this.userPassword, this.macAddress}) : super(key: key);
  String? userPhone;
  String? userPassword;
  String? macAddress;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController phoneNumberController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController(text: widget.userPhone ?? '');
    passwordController = TextEditingController(text: widget.userPassword ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000046),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // اضافه کردن فضای پایین
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Image.asset('images/logo.png', width: 150, height: 150),
                    Padding(padding: const EdgeInsets.only(top: 10, bottom: 10), child: Text('فست پی ان', style: context.textTheme.headlineLarge!.copyWith(fontSize: 48))),
                    Text('اپلیکیشن اتصال بدون محدودیت', style: context.textTheme.bodyLarge!.copyWith(fontSize: 24)),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 18),
                      child: TextField(
                        controller: phoneNumberController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'نام کاربری',
                          hintStyle: context.textTheme.displayMedium!.copyWith(fontSize: 18, color: Colors.black87),
                          suffixIcon: const Icon(Icons.person, color: Colors.black, size: 30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
                      child: TextField(
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'رمز عبور',
                          hintStyle: context.textTheme.displayMedium!.copyWith(fontSize: 18, color: Colors.black87),
                          suffixIcon: const Icon(Icons.key, color: Colors.black, size: 30),
                        ),
                      ),
                    ),
                    _buildLoginButton(),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        customDivider(),
                        Text('هنوز اشتراک تهیه نکردی؟', style: context.textTheme.displayLarge!.copyWith(fontSize: 14)),
                        customDivider(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildBuySubscriptionButton(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: () {
        if (phoneNumberController.text.isNotEmpty && passwordController.text.isNotEmpty) {
          BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(phoneNumber: phoneNumberController.text, password: passwordController.text, macAddress: widget.macAddress ?? ''));
        } else {
          showTopSnackBar(Overlay.of(Get.overlayContext!), const CustomSnackBar.error(message: 'نام کاربری و کلمه عبور را وارد کنید'));
        }
      },
      child: Container(
        width: 135,
        height: 45,
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white, width: 1.8),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Text('ورود', style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 24, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildBuySubscriptionButton() {
    return GestureDetector(
      onTap: openTelegram,
      child: Container(
        width: 353,
        height: 65,
        decoration: BoxDecoration(
            border: const GradientBoxBorder(gradient: LinearGradient(begin: Alignment.topRight, colors: [Color(0xffFFCE22), Color(0xff03DAC5)]), width: 2), borderRadius: BorderRadius.circular(13)),
        child: Center(
          child: Text('خرید اشتراک', style: Get.context!.textTheme.titleLarge!.copyWith(fontSize: 32)),
        ),
      ),
    );
  }
}
