import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/recette_data.dart';
import '../models/recette.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newId = recettes.isEmpty
        ? 1
        : recettes.map((recipe) => recipe.id).reduce(
              (a, b) => a > b ? a : b,
            ) +
            1;

    final newRecipe = Recette(
      id: newId,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      category: categoryController.text.trim(),
    );

    recettes.add(newRecipe);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recette ajoutée avec succès !'),
      ),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        context.go('/recipes');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une recette'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Nouvelle recette',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),

                  // Nom
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nom de la recette',
                      prefixIcon: Icon(Icons.restaurant),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Le nom est obligatoire';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Description
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La description est obligatoire';
                      }

                      if (value.trim().length < 10) {
                        return 'La description doit contenir au moins 10 caractères';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Catégorie
                  TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Catégorie',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La catégorie est obligatoire';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Bouton
                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: submitForm,
                      icon: const Icon(Icons.add),
                      label: const Text('Ajouter la recette'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}