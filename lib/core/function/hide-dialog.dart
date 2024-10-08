import 'package:get/get.dart';

hideDialog() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}
