import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:v2ray/bloc/vpn/vpn_bloc.dart';
import 'package:v2ray/core/class/model/pricing.dart';

import '../../core/class/MyPrefrences.dart';
import '../../core/class/get-imei.dart';
import 'login-screen.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  List<String> platforms = ['Android', 'IOS', 'Windows'];
  String platform = 'Android';
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initialPricing();
  }

  Future<void> initialPricing() async {
    String token = await MyPreferences.getUserPhoneNumber() ?? '';
    if (token.isNotEmpty) {
      BlocProvider.of<VpnBloc>(context).add(getPricing(token: token));
    } else {
      final userPhone = await MyPreferences.getUserPhoneNumber() ?? '';
      final userPassword = await MyPreferences.getUserPassword() ?? '';
      final macAddress = await ImeiManager.getDeviceIMEINumber();
      Get.offAll(LoginScreen(userPhone: userPhone, userPassword: userPassword, macAddress: macAddress));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff000046),
        elevation: 0,
        title: const Text('خرید اکانت', style: TextStyle(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff000046),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: List.generate(platforms.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        platform = platforms[index];
                      });
                    },
                    child: Container(
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: selectedIndex == index ? const [Color(0xffB88400), Color(0xffF1C40F)] : const [Color(0xffF39C12), Color(0xffD35400)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 2, blurRadius: 4, offset: const Offset(0, 3)),
                        ],
                        border: selectedIndex == index ? Border.all(color: Colors.white, width: 1.7) : Border.all(color: Colors.transparent),
                      ),
                      child: Center(
                        child: Text(
                          platforms[index].toString(),
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            BlocBuilder<VpnBloc, VpnState>(
              builder: (context, state) {
                if (state is VpnPricingFetchedState) {
                  if(state.pricing.isEmpty){
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text('تعرفه ای وجود ندارد', style: context.textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 24)),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.pricing.length,
                        itemBuilder: (context, index) {
                          return state.pricing[index].platform.contains(platform) ? _buildProductBanner(state.pricing[index]) : Container();
                        }),
                  );
                } else if (state is VpnErrorState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text('لیست قیمت ها دریافت نشد', style: context.textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 24)),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildProductBanner(Pricing pricing) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffF5F7FA), Color(0xffC3CFE2)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 2, blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Image.asset('images/product-banner.png', height: 100, width: 70),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pricing.serviceName, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xff2E3A59))),
                const SizedBox(height: 8),
                Text(pricing.duration, style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 18)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(' پلتفرم :', style: Get.context!.textTheme.bodyMedium!.copyWith(fontSize: 18)),
                    const SizedBox(width: 5),
                    Text(pricing.platform, style: TextStyle(fontSize: 18, color: Colors.grey[800])),
                    const SizedBox(width: 5),
                    pricing.platform == 'Android' ? const Icon(Icons.android, color: Colors.green) : const Icon(Icons.desktop_windows_outlined, color: Colors.blue),
                    const SizedBox(width: 5),
                    pricing.platform == 'Android,Windows' ? const Icon(Icons.android, color: Colors.green) : Container(),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(pricing.multiUser, style: TextStyle(fontSize: 16, color: Colors.grey[800])),
                    const Spacer(),
                    Text(pricing.price, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xff2E3A59))),
                    const SizedBox(width: 5),
                    const Icon(Icons.monetization_on, color: Color(0xffF39C12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
