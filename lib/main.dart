import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/store_provider.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => StoreProvider(),
      child: const MyApp(),
    ),
  );
}

