import 'package:get/get.dart';
import 'package:places/app/data/repository/home_repository.dart';
import 'package:places/app/modules/maps/bindings/maps_binding.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeRepoisotry());

    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<HomeRepoisotry>()),
    );
    MapsBinding().dependencies();
  }
}
