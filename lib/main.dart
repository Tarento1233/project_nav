import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/services/firebase_service.dart' as app_firebase_service;
import 'providers/store_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await app_firebase_service.FirebaseService.instance.initializeData();
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => StoreProvider(),
      child: const MyApp(),
    ),
  );
}

