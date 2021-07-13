import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:places/app/core/initialize_app.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await InitializeApp.initialize();
  SystemChannels.textInput.invokeMethod('TextInput.hide');

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    ),
  );
}
