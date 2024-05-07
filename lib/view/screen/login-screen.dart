import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:v2ray/bloc/auth/auth_bloc.dart';

import '../../core/function/get-imei.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Hello ,',
                style: TextStyle(color: Colors.blue, fontSize: 26),
              ),
            ),
            const Center(
              child: Text(
                'Welcome Back',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 100, bottom: 34),
              child: TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  hintText: 'Please Enter Your Phone Number',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:const Color(0xff3D83FF),
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: state is AuthLoadingState
                      ? null
                      : () async {
                          await Permission.phone.request();
                          String phoneNumber = phoneNumberController.text;
                          String macAddress =
                              await ImeiManager().getDeviceIMEINumber();

                          // start Event
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthLoginEvent(
                              phoneNumber: phoneNumber,
                              macAddress: macAddress,
                            ),
                          );
                          // end of Event
                        },
                  child: state is AuthLoadingState
                      ? const CircularProgressIndicator()
                      : const Text(
                          'LOG IN',
                          style: TextStyle(fontSize: 24),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
