import 'package:flutter/material.dart';
import 'package:todo_list/core/components/custom_filled_button.dart';
import 'package:todo_list/core/utils/guide_line.dart';

class StatusMessageListConstants {
  static const double iconSize = 100;
  static const double verticalPadding = 16;
  static const double bottomIconSpace = 20;
  static const double bottomMessageSpace = 30;
  static const double spaceBetweenTitleToDescription = 10;
}

/// A widget that displays a status message with an icon, title, description,
/// and an action button.
///
/// This widget is useful for showing messages in various situations, such as
/// when there are no tasks or when an error has occurred.
class StatusMessageList extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const StatusMessageList({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GuideLine.horizontalPaddingScreen,
          vertical: GuideLine.verticalPaddingScreen,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(context),
            const SizedBox(height: StatusMessageListConstants.bottomIconSpace),
            ..._buildMessage(context),
            const SizedBox(height: StatusMessageListConstants.bottomMessageSpace),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(
      icon,
      size: StatusMessageListConstants.iconSize,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  List<Widget> _buildMessage(BuildContext context) {
    return [
      Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(
        height: StatusMessageListConstants.spaceBetweenTitleToDescription,
      ),
      Text(
        description,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ];
  }

  Widget _buildButton(BuildContext context) {
    return CustomFilledButton(
      onPressed: onButtonPressed,
      text: buttonText,
    );
  }
}
