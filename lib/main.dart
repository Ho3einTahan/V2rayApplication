import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:v2ray/bloc/auth/auth_bloc.dart';
import 'package:v2ray/view/screen/home-screen.dart';

import 'core/class/model/MyPrefrences.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  MyPreferences.initPrefrences();
  runApp(BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: Scaffold(
        bottomNavigationBar: Container(
          alignment: Alignment.bottomCenter,
          height: 75,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            border: GradientBoxBorder(gradient: LinearGradient(begin: Alignment.topRight, colors: [Color(0xff23C95B), Color(0xff6F34FE)]), width: 3.5),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 6.0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(icon: const Icon(Icons.home, size: 32), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.filter_list_alt, size: 32), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.add, size: 32), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.person, size: 32), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.settings, size: 32), onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder<bool>(
          future: MyPreferences.readUserIsLogin(),
          builder: (context, snapshot) {
            if (snapshot.data == false) {
              return HomeScreen(serverConfig: const []);
            } else {
              return HomeScreen(serverConfig: const []);
            }
          },
        ),
      ),
    );
  }
}
