import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/custom-divider.dart';

class BuyAccountScreen extends StatefulWidget {
  const BuyAccountScreen({super.key});

  @override
  State<BuyAccountScreen> createState() => _BuyAccountScreenState();
}

class _BuyAccountScreenState extends State<BuyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000046),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customDivider(),
                  const Text('خرید اکانت', style: TextStyle(color: Colors.white)),
                  customDivider(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildUnlimitedAccount(),
                _buildVolumeAccount(),
              ],
            ),
            const SizedBox(height: 24),
            _buildProductBanner(),
          ],
        ),
      ),
    );
  }
}

Widget _buildUnlimitedAccount() {
  return Container(
    height: 120,
    width: 140,
    decoration: BoxDecoration(
      gradient: const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xff146B84), Color(0xff000046)]),
      borderRadius: BorderRadius.circular(19),
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.clean_hands_sharp, size: 35, color: Colors.white),
        SizedBox(height: 10),
        Text('اکانت نامحدود', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _buildVolumeAccount() {
  return Container(
    height: 120,
    width: 140,
    decoration: BoxDecoration(
      gradient: const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xff38EF7D), Color(0xff11998E)]),
      borderRadius: BorderRadius.circular(19),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.bag, size: 35, color: Colors.white),
        SizedBox(height: 10),
        Text('اکانت حجمی', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _buildProductBanner() {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset('images/product-banner.png'),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('یک ماهه نامحدود', style: TextStyle(color: Colors.black, fontSize: 20)),
                  Row(
                    children: [
                      Icon(Icons.list, color: Colors.black),
                      Text('نامحدود', style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.black),
                      SizedBox(width: 8),
                      Expanded(child: Text('3 کاربر', style: TextStyle(color: Colors.black, fontSize: 16))),
                      Text('1,100,000', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                      Icon(Icons.monetization_on, color: Colors.black),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
