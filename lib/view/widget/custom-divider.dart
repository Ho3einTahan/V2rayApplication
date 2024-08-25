

import 'package:flutter/material.dart';

Widget customDivider() {
  return const Expanded(
    child: Divider(
      indent: 20, // فاصله از متن
      thickness: 2, // ضخامت خط
      endIndent: 20,
      color: Colors.white, // رنگ خط
    ),
  );
}