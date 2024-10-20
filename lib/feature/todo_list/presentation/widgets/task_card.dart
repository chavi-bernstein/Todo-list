import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/core/utils/guide_line.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/task_complition_cubit.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/task_details.dart';

class TaskCardConstants {
  static const String priority = 'Priority';
  static const String delete = 'Delete';
  static const String complete = 'Complete';
  static const String unComplete = 'Un complete';
  static const double elevation = 2;
}

/// A widget that displays a task card with options to complete or delete the task.
///
/// This card is interactive and allows users to toggle task completion status or delete the task.
/// It uses [Slidable] to provide swipe actions for task management.
/// When tapped, it opens a modal bottom sheet to display detailed information about the task.
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCompletionCubit>(
      create: (context) => TaskCompletionCubit(
        isCompleted: task.isCompleted,
      ),
      child: BlocBuilder<TaskCompletionCubit, bool>(
        builder: (context, taskCompletionState) {
          return Slidable(
            key: Key(task.title),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                _buildDeleteSlidableAction(),
                _buildCompletedSlidableAction(taskCompletionState),
              ],
            ),
            child: _buildCard(context, taskCompletionState),
          );
        },
      ),
    );
  }

  // Builds the delete action for the slidable menu.
  SlidableAction _buildDeleteSlidableAction() {
    return SlidableAction(
      onPressed: _deleteItem,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: TaskCardConstants.delete,
    );
  }

  void _deleteItem(BuildContext context) {
    BlocProvider.of<TodoListBloc>(context).add(
      DeleteTask(task: task),
    );
  }

  // Builds the action for completing or un-completing the task.
  SlidableAction _buildCompletedSlidableAction(bool isCompleted) {
    return SlidableAction(
      onPressed: (context) => _toggleComplete(context),
      backgroundColor: isCompleted ? Colors.grey : Colors.green,
      foregroundColor: Colors.white,
      icon: isCompleted ? Icons.cancel : Icons.check_circle,
      label: isCompleted
          ? TaskCardConstants.unComplete
          : TaskCardConstants.complete,
    );
  }

  // Toggles the completion status of the task.
  void _toggleComplete(BuildContext context) {
    BlocProvider.of<TaskCompletionCubit>(context).toggleComplete(task);
  }

  Widget _buildCard(BuildContext context, bool isCompleted) {
    return Card(
      elevation: TaskCardConstants.elevation,
      child: ListTile(
        title: Text(
          task.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text('${TaskCardConstants.priority}: ${task.priority.name}'),
        trailing: _buildTrailing(isCompleted),
        onTap: () => _onTap(context, isCompleted),
      ),
    );
  }

  Widget? _buildTrailing(bool isCompleted) {
    return isCompleted ? _buildCompletedIcon() : null;
  }

  Widget _buildCompletedIcon() {
    return const Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  // Opens a modal bottom sheet to display task details.
  void _onTap(BuildContext context, bool isCompleted) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            GuideLine.topBorderRadiusBottomSheet,
          ),
        ),
      ),
      builder: (BuildContext context) {
        return TaskDetails(
          task: task.copyWith(isCompleted: isCompleted),
        );
      },
    );
  }
}
