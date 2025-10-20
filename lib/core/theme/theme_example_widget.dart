import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme.dart';

/// Example widget demonstrating how to use the new theme system
class ThemeExampleWidget extends StatelessWidget {
  const ThemeExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Theme Example',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          // Theme switcher button
          GetBuilder<ThemeController>(
            builder: (themeController) {
              return IconButton(
                icon: Icon(themeController.themeModeIcon),
                onPressed: () => themeController.cycleTheme(),
                tooltip: 'Theme: ${themeController.themeModeDisplayName}',
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Primary button example
            ElevatedButton(
              onPressed: () {},
              child: const Text('Primary Button'),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Outlined button example
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Card example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Title',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'This is an example card showing how the theme system works.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Input field example
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Color showcase
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Column(
                children: [
                  Text(
                    'Primary Container',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'This demonstrates semantic colors from the design system.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Theme info
            GetBuilder<ThemeController>(
              builder: (themeController) {
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Theme:',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        themeController.themeModeDisplayName,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example of using GetX to access theme controller
          Get.find<ThemeController>().toggleTheme();
        },
        child: const Icon(Icons.palette),
      ),
    );
  }
}

/// Helper widget for theme showcase
class ColorCircle extends StatelessWidget {
  final Color color;
  final String label;

  const ColorCircle({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: context.colorScheme.outline, width: 1),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
