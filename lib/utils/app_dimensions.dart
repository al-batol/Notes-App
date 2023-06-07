import 'package:get/get.dart';

class AppDimensions {
  static final height = Get.height;
  static final width = Get.width;

  static double responsiveWidth(double value) {
    const double baseWidth = 411.0;
    return value / width * baseWidth;
  }

  static double responsiveHeight(double value) {
    const double baseHeight = 820.0;
    return value / height * baseHeight;
  }
}

extension Responsive on double {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
  double get sp => (Get.width / 100 * (this / 3));
}