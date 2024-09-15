// app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/providers/theme_provider.dart';

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Build the MaterialApp widget based on the current theme mode.
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Kinetic QR',
          themeMode: themeProvider.themeMode, // Use the current theme mode.
          theme: ThemeData.light().copyWith(
            // Light theme customization.
            primaryColor: Colors.blue,
            hintColor: Colors.blueAccent,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              color: Colors.blue,
              elevation: 4,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            // Dark theme customization.
            primaryColor: Colors.blueGrey,
            hintColor: Colors.blueGrey,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              color: Colors.blueGrey,
              elevation: 4,
            ),
          ),
          home: const HomeScreen(), // The initial screen of the app.
          debugShowCheckedModeBanner: false, // Disable the debug banner.
        );
      },
    );
  }
}
