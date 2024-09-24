import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:v2ray/bloc/auth/auth_bloc.dart';
import 'package:v2ray/bloc/vpn/vpn_bloc.dart';
import 'package:v2ray/core/constants/routes.dart';
import 'package:v2ray/utils/app-them.dart';
import 'package:v2ray/view/screen/login-screen.dart';

import 'di/di.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  getItInit();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      BlocProvider<VpnBloc>(create: (context) => VpnBloc()),
    ], child: Application()),
  );
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.getPages,
      theme: AppTheme(),
      home: Scaffold(
        backgroundColor: const Color(0xff000046),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            // CountryScreen(),
            // HomeScreen(serverConfig: []),
            // SettingScreen(),`
            // SplitTunnelingScreen(),
            // ProfileScreen(),
            LoginScreen(),
            // NotificationScreen(),
            // BuyAccountScreen(),
          ],
        ),
        // bottomNavigationBar: Container(
        //   alignment: Alignment.bottomCenter,
        //   height: 75,+

        //   decoration: const BoxDecoration(
        //     color: Color(0xff1D192B),
        //     borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        //     border: GradientBoxBorder(gradient: LinearGradient(begin: Alignment.topRight, colors: [Color(0xff23C95B), Color(0xff6F34FE)]), width: 3.5),
        //   ),
        //   child: Center(
        //     child: ClipRRect(
        //       borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        //       child: BottomAppBar(
        //         shape: const CircularNotchedRectangle(),
        //         notchMargin: 6.0,
        //         color: const Color(0xff1D192B),
        //         child: Row(
        //           mainAxisSize: MainAxisSize.max,
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: <Widget>[
        //             IconButton(icon: const Icon(Icons.home, size: 32), onPressed: () => _onItemTapped(0)),
        //             IconButton(icon: const Icon(Icons.person, size: 32), onPressed: () => _onItemTapped(1)),
        //             IconButton(icon: const Icon(Icons.settings, size: 32), onPressed: () => _onItemTapped(2)),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
