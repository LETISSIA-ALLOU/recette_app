import 'package:flutter/material.dart';

import '../data/recette_data.dart';
import '../models/recette.dart';
import '../utils/recette_validator.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _addRecipe() {
    // Validation des champs du formulaire.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validation de la logique métier.
    final validationError = validateRecipe(
      name: _nameController.text,
      description: _descriptionController.text,
      category: _categoryController.text,
    );

    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationError),
        ),
      );
      return;
    }

    // Génération automatique d'un nouvel ID.
    final newId = generateRecipeId(recettes);

    final newRecipe = Recette(
      id: newId,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _categoryController.text.trim(),
    );

    // Ajout de la recette à la liste.
    recettes.add(newRecipe);

    // Message de confirmation.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recette ajoutée avec succès !'),
      ),
    );

    // Retour à la liste des recettes.
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez saisir le nom de la recette.';
    }

    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez saisir une description.';
    }

    return null;
  }

  String? _validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez saisir une catégorie.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une recette'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Nouvelle recette',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom de la recette',
                  hintText: 'Ex. Poulet braisé',
                  prefixIcon: Icon(Icons.restaurant),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: _validateName,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Décrivez votre recette',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                textInputAction: TextInputAction.next,
                validator: _validateDescription,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Catégorie',
                  hintText: 'Ex. Africaine',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                validator: _validateCategory,
              ),

              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: _addRecipe,
                icon: const Icon(Icons.add),
                label: const Text('Ajouter la recette'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
