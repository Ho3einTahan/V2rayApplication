import 'package:flutter/material.dart';

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
                  _buildDivider(),
                  Text('اطلاع رسانی ...', style: TextStyle(color: Colors.white)),
                  _buildDivider(),
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
    child: Column(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/banner.png', height: 70),
              ],
            ),
            Text('تخفیف 10 درصدی اولین ورود'),
            _buildPromoBadge(),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDivider() {
  return const Expanded(
    child: Divider(
      indent: 20, // فاصله از متن
      thickness: 2, // ضخامت خط
      endIndent: 20,
      color: Colors.white, // رنگ خط
    ),
  );
}

Widget _buildPromoBadge() {
  return Container(
    width: 41,
    height: 20 ,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(colors: [Color(0xff03DAC5), Color(0xffFFCE22)]),
      border: Border.all(color: Colors.white),
    ),
    child: const Center(child: Text('10%')),
  );
}

Widget _buildCopyButton() {
  return Container(child: const Center(child: Icon(Icons.paste_outlined)));
}
