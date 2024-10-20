import 'package:flutter/material.dart';
import 'package:todo_list/core/utils/date_helper.dart';
import 'package:todo_list/core/utils/guide_line.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';

class TodoItemDetailsConstants {
  static const double initialChildSize = 0.3;
  static const double minChildSize = 0.2;
  static const double maxChildSize = 0.8;
  static const double verticalPadding = 16;
  static const double spaceBetweenHeaderToItems = 20;
  static const double spaceBetweenItems = 10;
  static const int valueMaxLine = 3;
  static const String description = "Description";
  static const String noDescription = "No description";
  static const String deadline = "Deadline";
  static const String completed = "Completed";
  static const String priority = "Priority";
  static const String creationDate = "Creation Date";
}

/// A widget that displays detailed information about a task in a draggable bottom sheet.
///
/// This widget shows various attributes of the task, including the title, description,
/// creation date, deadline, priority, and completion status.
class TaskDetails extends StatelessWidget {
  const TaskDetails({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: TodoItemDetailsConstants.initialChildSize,
      minChildSize: TodoItemDetailsConstants.minChildSize,
      maxChildSize: TodoItemDetailsConstants.maxChildSize,
      expand: false,
      builder: (context, scrollController) {
        return _buildTodoDetailsSheet(context, scrollController);
      },
    );
  }

  Widget _buildTodoDetailsSheet(
      BuildContext context, ScrollController scrollController) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: GuideLine.horizontalPaddingScreen,
        vertical: GuideLine.verticalPaddingScreen,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            GuideLine.topBorderRadiusBottomSheet,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: _buildItems(context, scrollController),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        task.title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildItems(BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: TodoItemDetailsConstants.spaceBetweenHeaderToItems,
          ),
          _buildKeyValueDetail(
            context,
            TodoItemDetailsConstants.description,
            _buildTextValue(
              context,
              task.description ?? TodoItemDetailsConstants.noDescription,
            ),
          ),
          _buildSpaceBetweenItems(),
          _buildKeyValueDetail(
            context,
            TodoItemDetailsConstants.creationDate,
            _buildTextValue(
              context,
              _formatDate(task.creationDate),
            ),
          ),
          if (task.deadline != null) _buildSpaceBetweenItems(),
          if (task.deadline != null)
            _buildKeyValueDetail(
              context,
              TodoItemDetailsConstants.deadline,
              _buildTextValue(context, _formatDate(task.deadline!)),
            ),
          _buildSpaceBetweenItems(),
          _buildKeyValueDetail(
            context,
            TodoItemDetailsConstants.priority,
            _buildTextValue(context, task.priority.name),
          ),
          _buildSpaceBetweenItems(),
          _buildKeyValueDetail(
            context,
            TodoItemDetailsConstants.completed,
            Icon(
              task.isCompleted ? Icons.check_circle : Icons.cancel,
              color: task.isCompleted ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // Builds a key-value detail row with a label and a corresponding value.
  Widget _buildKeyValueDetail(
      BuildContext context, String label, Widget value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        Flexible(
          child: value,
        ),
      ],
    );
  }

  Widget _buildTextValue(BuildContext context, String value) {
    return Text(
      value,
      style: Theme.of(context).textTheme.bodyLarge,
      maxLines: TodoItemDetailsConstants.valueMaxLine,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSpaceBetweenItems() {
    return const SizedBox(
      height: TodoItemDetailsConstants.spaceBetweenItems,
    );
  }

  String _formatDate(DateTime date) {
    return DateHelper.getDateFormat(date);
  }
}
