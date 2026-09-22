import 'package:flutter/material.dart';

import 'routes/app_router.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    final router = createRouter(
      themeMode: themeMode,
      onThemeChanged: (mode) {
        setState(() {
          themeMode = mode;
        });
      },
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      themeMode: themeMode,

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
        brightness: Brightness.dark,
      ),

      routerConfig: router,
    );
  }
}