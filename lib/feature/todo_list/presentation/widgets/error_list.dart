import 'package:flutter/material.dart';
import 'package:todo_list/core/components/custom_filled_button.dart';
import 'package:todo_list/core/utils/guide_line.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/status_message_list.dart';

class ErrorListConstants {
  static const String title = 'An error occurred!';
  static const String description = 'Please try again later.';
  static const String buttonText = 'Retry';
}
/// Displays an error message with a retry option.
class ErrorList extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorList({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return StatusMessageList(
      icon: Icons.error,
      title: ErrorListConstants.title,
      description: ErrorListConstants.description,
      buttonText: ErrorListConstants.buttonText,
      onButtonPressed: onRetry,
    );
  }
}
