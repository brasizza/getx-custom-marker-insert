import 'package:get/get.dart';

import 'package:places/app/modules/home/bindings/home_binding.dart';
import 'package:places/app/modules/home/views/home_view.dart';
import 'package:places/app/modules/maps/bindings/maps_binding.dart';
import 'package:places/app/modules/maps/views/maps_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => MapsView(),
      binding: MapsBinding(),
    ),
  ];
}
