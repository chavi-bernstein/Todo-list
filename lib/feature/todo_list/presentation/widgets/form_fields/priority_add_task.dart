import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/feature/todo_list/domain/enums/priority.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/add_task_cubits/priority_add_task_cubit.dart';

class PriorityAddTaskConstants {
  static const String labelText = 'Priority';
  static const String hintText = 'Enter priority';
}

/// A widget that allows the user to enter a priority for a task.
///
/// This widget displays a text field where the user can input a task priority.
/// It uses [PriorityAddTaskCubit] to manage the priority state.
class PriorityAddTask extends StatelessWidget {
  const PriorityAddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriorityAddTaskCubit, Priority?>(
      builder: (context, state) {
        return DropdownButtonFormField<Priority>(
          decoration: const InputDecoration(
            labelText: PriorityAddTaskConstants.labelText,
            hintText: PriorityAddTaskConstants.hintText,
          ),
          items: _buildPriorityItems(),
          onChanged:(value)=> _onPriorityChanged(context,value),
        );
      },
    );
  }

  List<DropdownMenuItem<Priority>>? _buildPriorityItems() {
    return Priority.values.map((Priority priority) {
      return DropdownMenuItem<Priority>(
        value: priority,
        child: Text(priority.name),
      );
    }).toList();
  }
  void _onPriorityChanged(BuildContext context, Priority? value) {
    BlocProvider.of<PriorityAddTaskCubit>(context).updatePriority(value);
  }
}
