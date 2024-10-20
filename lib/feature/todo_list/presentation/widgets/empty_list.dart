import 'package:flutter/material.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/status_message_list.dart';

class EmptyListConstants {
  static const String title = 'No tasks available!';
  static const String description = 'Let\'s get started by adding a new task.';
  static const String buttonText = 'Add task';
}

/// Displays a message when the task list is empty and option to add task.
class EmptyList extends StatelessWidget {
  final VoidCallback onAddTask;

  const EmptyList({
    super.key,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    return StatusMessageList(
      icon: Icons.close,
      title: EmptyListConstants.title,
      description: EmptyListConstants.description,
      buttonText: EmptyListConstants.buttonText,
      onButtonPressed: onAddTask,
    );
  }
}
