import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:v2ray/bloc/auth/auth_bloc.dart';
import 'package:v2ray/view/screen/home-screen.dart';
import 'package:v2ray/view/screen/login-screen.dart';
import 'package:v2ray/view/screen/veryfication-screen.dart';
import 'di/di.dart';

void main() async {
  await getItInit();
  runApp(BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp (
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: Scaffold(body: LoginScreen()),
    );
  }
}
