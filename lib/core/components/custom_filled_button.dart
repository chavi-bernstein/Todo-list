import 'package:flutter/material.dart';

/// A customizable filled button for consistent styling across the app.
class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton(
      {super.key, required this.onPressed, required this.text});

  /// Callback function that is called when the button is pressed.
  final void Function() onPressed;

  /// The text displayed on the button.
  final String text;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      child: Text(text),
    );
  }
}
