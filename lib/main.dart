// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'app.dart';

/// The main entry point of the application.
void main() {
  runApp(
    // Wrap the entire app in a ChangeNotifierProvider
    // to provide the ThemeProvider to all widgets in the app.
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
