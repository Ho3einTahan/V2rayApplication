import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

Widget buildHeader(String title, String imgName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      buildBackButton(),
      _buildUserInfo(title, imgName),
    ],
  );
}

Widget _buildUserInfo(String title, String imgName) {
  return Container(
    width: 260,
    height: 55,
    decoration: BoxDecoration(
        color: const Color(0xff1D192B),
        border: const GradientBoxBorder(gradient: LinearGradient(begin: Alignment.topRight, colors: [Color(0xff23C95B), Color(0xff6F34FE)]), width: 2),
        borderRadius: BorderRadius.circular(14)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: Get.context!.textTheme.headlineLarge!.copyWith(fontSize: 18)),
        const SizedBox(width: 10),
        Container(
          width: 45,
          height: 45,
          margin: const EdgeInsets.only(left: 21),
          decoration: BoxDecoration(
              color: const Color(0xff1D192B),
              border: const GradientBoxBorder(gradient: LinearGradient(begin: Alignment.topRight, colors: [Color(0xff23C95B), Color(0xff6F34FE)]), width: 2),
              borderRadius: BorderRadius.circular(14)),
          child: Center(child: Image.asset('images/${imgName}.png')),
        ),
        const SizedBox(width: 5),
      ],
    ),
  );
}

Widget buildBackButton() {
  return GestureDetector(
    onTap: () => Get.back(),
    child: Container(
      width: 55,
      height: 55,
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: const Color(0xff1D192B),
        border: const GradientBoxBorder(gradient: LinearGradient(begin: Alignment.topRight, colors: [Color(0xff23C95B), Color(0xff6F34FE)]), width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(Icons.arrow_back_ios),
    ),
  );
}
