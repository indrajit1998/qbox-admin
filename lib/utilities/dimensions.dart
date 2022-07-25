import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height; //792 for my screen
  static double screenWidth = Get.context!.width; //1536 for my screen

  static double circularRadius =
      screenHeight < screenWidth ? screenHeight / 24.75 : screenWidth / 24.75;

  static double height10 = screenHeight / 82;
  static double width10 = screenWidth / 41;

  static double padding20 = screenWidth / 20.5;

  static double borderRadius12 = screenHeight / 68.3333333333;
  static double borderRadius5 = screenHeight / 164;
}
