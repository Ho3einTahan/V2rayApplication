import 'package:flutter/material.dart';

import '../widget/custom-divider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
                 const Text('اطلاع رسانی ...', style: TextStyle(color: Colors.white)),
                  customDivider(),
                ],
              ),
            ),
            _buildBanner(),
          ],
        ),
      ),
    );
  }
}

Widget _buildBanner() {
  return Container(
    height: 80,
    margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 17),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: const Color(0xff454545),
    ),
    child: Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset('images/banner.png', height: 70),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                const Text('تخفیف 10 درصدی اولین ورود'),
                const SizedBox(width: 10),
                _buildPromoBadge(),
              ],
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                _buildCopyButton(),
                const SizedBox(width: 10),
                const Text('رایگان', style: TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(width: 10),
                const Icon(Icons.currency_pound_rounded, color: Colors.yellow),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}



Widget _buildPromoBadge() {
  return Container(
    width: 41,
    height: 20,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(colors: [Color(0xff03DAC5), Color(0xffFFCE22)]),
      border: Border.all(color: Colors.white),
    ),
    child: const Center(child: Text('10%')),
  );
}

Widget _buildCopyButton() {
  return Container(
      width: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(
              child: Icon(
            Icons.paste_outlined,
            color: Color(0xff80F98A),
          )),
          Text('کپی کردن', style: TextStyle(color: Colors.black, fontSize: 20)),
        ],
      ));
}
