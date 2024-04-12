import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
                child: Text(
              'Hello ,',
              style: TextStyle(color: Colors.blue, fontSize: 26),
            )),
            Center(
                child: Text(
              'Welcome  Back',
              style: TextStyle(fontSize: 24),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: TextField(
                decoration:
                    InputDecoration(hintText: 'Pleas Enter Your Phone Number'),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {},
                child: Text(
                  'LOG IN',
                  style: TextStyle(fontSize: 24),
                )),
          ],
        ),
      ),
    );
  }
}
