import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('themeMode');

    ThemeMode mode = ThemeMode.light;

    switch (savedTheme) {
      case 'dark':
        mode = ThemeMode.dark;
        break;
      case 'system':
        mode = ThemeMode.system;
        break;
      case 'light':
      default:
        mode = ThemeMode.light;
    }

    if (!mounted) return;

    setState(() {
      themeMode = mode;
    });
  }

  Future<void> _changeTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    String themeValue;

    switch (mode) {
      case ThemeMode.light:
        themeValue = 'light';
        break;
      case ThemeMode.dark:
        themeValue = 'dark';
        break;
      case ThemeMode.system:
        themeValue = 'system';
        break;
    }

    await prefs.setString('themeMode', themeValue);

    if (!mounted) return;

    setState(() {
      themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = createRouter(
      themeMode: themeMode,
      onThemeChanged: _changeTheme,
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