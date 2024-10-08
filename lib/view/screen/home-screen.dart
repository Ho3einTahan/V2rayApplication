import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:v2ray/core/class/MyPrefrences.dart';
import 'package:v2ray/view/screen/servers-screen.dart';
import 'package:v2ray/view/screen/setting-screen.dart';

import '../../core/class/model/servers.dart';
import '../widget/dots-loading.dart';
import '../widget/v2ray-status-widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCountryNameAndImage = '';
  String selectedServerAddress = '';
  String userName = '';
  String myIpAddress = "";
  final Map<String, dynamic> arguments = Get.arguments;

  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) async {
      v2rayStatus.value = status;
      try {
        myIpAddress = await Ipify.ipv4();
      } catch (e) {
        myIpAddress = 'Unable to retrieve IP address';
      }
      setState(() {});
    },
  );

  void onConnect(String linkAddress) async {
    V2RayURL parser = FlutterV2ray.parseFromURL(linkAddress);
    List<String> appTunnels = await MyPreferences.getAppTunnels() ?? [];
    if (await flutterV2ray.requestPermission()) {
      flutterV2ray.startV2Ray(remark: parser.remark, config: parser.getFullConfiguration(), proxyOnly: false, bypassSubnets: [], blockedApps: appTunnels);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Permission Denied')));
    }
  }

  @override
  void initState() {
    super.initState();
    initialServer();
    flutterV2ray.initializeV2Ray().then((value) {
      setState(() {});
    });
  }

  Future<void> initialServer() async {
    userName = await MyPreferences.getUserName() ?? '';
    selectedCountryNameAndImage = await MyPreferences.getCountryNameAndImage() ?? '';
    selectedServerAddress = await MyPreferences.getSelectedServerAddress() ?? '';
    print(selectedServerAddress);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Servers> servers = arguments['servers'];
    return Scaffold(
      backgroundColor: const Color(0xff000046),
      appBar: AppBar(elevation: 0, backgroundColor: const Color(0xff000046)),
      drawer: const SettingScreen(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: v2rayStatus,
          builder: (context, status, child) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 70,
                  margin: const EdgeInsets.only(left: 31, right: 31, top: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xff1D192B),
                    borderRadius: BorderRadius.circular(20),
                    border: const GradientBoxBorder(gradient: LinearGradient(begin: Alignment.topRight, colors: [Color(0xff23C95B), Color(0xff6F34FE)]), width: 3.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text('سلام', style: context.textTheme.headlineLarge!.copyWith(fontSize: 20, color: const Color(0xffB88400))),
                      const SizedBox(width: 7),
                      Text(userName, style: context.textTheme.headlineLarge!.copyWith(fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 65),
                _buildChooseCountry(servers),
                _buildConnectStatus(status),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildChooseCountry(List<Servers> servers) {
    return GestureDetector(
      onTap: () async {
        List<String>? callback = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ServersScreen(servers: servers)));
        if (callback != null && callback.isNotEmpty) {
          if (callback[0] != selectedCountryNameAndImage) {
            selectedCountryNameAndImage = callback[0];
            selectedServerAddress = callback[1];
            MyPreferences.setSelectedServerAddress(serverAddress: selectedServerAddress);
            MyPreferences.setCountryNameAndImage(countryNameAndImage: selectedCountryNameAndImage);

            setState(() {});
          }
        }
      },
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(color: const Color(0xff353351).withOpacity(0.7), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.transparent)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 12),
                  child: selectedCountryNameAndImage.isEmpty ? const Icon(Icons.question_mark_outlined) : Image.asset('images/${selectedCountryNameAndImage.toLowerCase()}.png')),
              Text(selectedCountryNameAndImage.isEmpty ? 'لطفا یک سرور را انتخاب کنید' : selectedCountryNameAndImage,
                  style: context.textTheme.displaySmall!.copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
              const Spacer(),
              const Icon(CupertinoIcons.right_chevron),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectStatus(V2RayStatus status) {
    return Container(
      width: 360,
      height: 350,
      margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 21),
      padding: const EdgeInsets.only(right: 32),
      decoration: const BoxDecoration(
        color: Color(0xff1D192B),
        border: GradientBoxBorder(width: 3, gradient: LinearGradient(colors: [Color(0xff23C95B), Color(0xff6F34FE)])),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(71), bottomRight: Radius.circular(71)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(padding: const EdgeInsets.only(left: 24), child: buildStatusText(status.state)),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text('آدرس آیپی  :   ', textDirection: TextDirection.rtl, style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.white)),
              myIpAddress.isEmpty ? LoadingDots() : Text(myIpAddress, style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: myIpAddress.length > 10 ? 15 : 20, color: Colors.white)),
              const SizedBox(width: 3),
              const Icon(Icons.flag, color: Colors.black),
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text('سرعت دانلود  :  ', textDirection: TextDirection.rtl, style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.white)),
              Text(status.downloadSpeed.toString(), style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.white)),
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text('سرعت آپلود  :  ', textDirection: TextDirection.rtl, style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.white)),
              Text(status.uploadSpeed.toString(), style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.white)),
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text('زمان  :  ', textDirection: TextDirection.rtl, style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.white)),
              Text(status.duration.toString(), style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.white)),
            ],
          ),
          GestureDetector(
              onTap: () {
                if (status.state == 'CONNECTED') {
                  flutterV2ray.stopV2Ray();
                } else {
                  onConnect(selectedServerAddress);
                }
                myIpAddress = '';
              },
              child: buildStatusButton(status.state)),
        ],
      ),
    );
  }
}
