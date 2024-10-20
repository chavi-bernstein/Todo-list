import 'package:flutter/material.dart';

/// A customizable app bar with a centered title.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  /// The title text displayed in the app bar.
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
      title: Text(title),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
