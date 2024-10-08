import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:v2ray/bloc/auth/auth_bloc.dart';
import 'package:v2ray/bloc/vpn/vpn_bloc.dart';
import 'package:v2ray/core/constants/routes.dart';
import 'package:v2ray/utils/app-them.dart';
import 'package:v2ray/view/screen/login-screen.dart';
import 'package:v2ray/view/screen/no-internet-screen.dart';

import 'core/class/MyPrefrences.dart';
import 'core/class/get-imei.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<VpnBloc>(create: (context) => VpnBloc()),
      ],
      child: Application(),
    ),
  );
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  bool isConnected = true;
  String userPhone = '';
  String userPass = '';
  String deviceMacAddress = '';
  bool isLoading = true;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _initializeUserCredentials();
    _monitorInternetConnection();
  }

  Future<void> _initializeUserCredentials() async {
    try {
      userPhone = await MyPreferences.getUserPhoneNumber() ?? '';
      userPass = await MyPreferences.getUserPassword() ?? '';
      deviceMacAddress = await ImeiManager.getDeviceIMEINumber();
    } catch (e) {
      print('Error loading user credentials: $e');
    }
    setState(() {
      isLoading = false;
    });

    if (userPhone.isNotEmpty && userPass.isNotEmpty) {
      BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(phoneNumber: userPhone, password: userPass, macAddress: deviceMacAddress));
    }
  }

  Future<void> _checkInternetConnection() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    setState(() {
      isConnected = (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
    });
  }

  void _monitorInternetConnection() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        isConnected = (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.getPages,
      theme: AppTheme(),
      home: _buildHomeScreen(userPhone, userPass, deviceMacAddress),
    );
  }

  Widget _buildHomeScreen(String userPhone, String userPass, String macAddress) {
    return FutureBuilder<bool>(
      future: MyPreferences.getIsUserLoggedIn(),
      builder: (context, snapshot) {
        if (!isConnected) {
          return const NoInternetScreen();
        }

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return LoginScreen(userPhone: userPhone, userPassword: userPass, macAddress: macAddress);
      },
    );
  }
}
