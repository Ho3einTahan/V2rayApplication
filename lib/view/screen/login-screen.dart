import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:v2ray/bloc/auth/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Hello,',
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 34),
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
                if (state is AuthLoadingState) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: const Size(200, 50),
                    ),
                    onPressed: null,
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: const Size(200, 50),
                    ),
                    onPressed: () async {
                      await Permission.phone.request();
                      String phoneNumber = phoneNumberController.text;
                      String macAddress = await _getDeviceIMEINumber();

                      BlocProvider.of<AuthBloc>(context).add(
                        AuthLoginEvent(
                          phoneNumber: phoneNumber,
                          macAddress: macAddress,
                        ),
                      );
                    },
                    child: const Text(
                      'LOG IN',
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                // Handle sign-up button press
              },
              child: const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getDeviceIMEINumber() async {
    try {
      return await DeviceInformation.deviceIMEINumber;
    } catch (e) {
      return '';
    }
  }
}
