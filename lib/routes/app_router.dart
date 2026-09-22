import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_recipe_screen.dart';
import '../screens/home_screen.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/recipes_screen.dart';
import '../screens/settings_screen.dart';

GoRouter createRouter({
  required ThemeMode themeMode,
  required ValueChanged<ThemeMode> onThemeChanged,
}) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/recipes',
        builder: (context, state) => const RecipesScreen(),
      ),
      GoRoute(
        path: '/recipes/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);

          return RecipeDetailScreen(
            recipeId: id,
          );
        },
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) => const AddRecipeScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsScreen(
          themeMode: themeMode,
          onThemeChanged: onThemeChanged,
        ),
      ),
    ],
  );
}