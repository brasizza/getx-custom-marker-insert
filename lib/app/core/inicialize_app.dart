import 'package:flutter/material.dart';
import 'package:places/app/core/initialize_db.dart';
import 'package:places/app/core/initialize_gps.dart';

class InitializeApp {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await InitializeDatabase.initialize();
    await InitializeGps.initialize();
  }
}
