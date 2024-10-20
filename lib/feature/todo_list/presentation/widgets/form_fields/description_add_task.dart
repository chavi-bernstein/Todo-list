import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/add_task_cubits/description_add_task_cubit.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/form_fields/custom_text_field.dart';

class DescriptionAddTaskConstants {
  static const String labelText = 'Description';
  static const String hintText = 'Enter description';
}

/// A widget that allows the user to enter a description for a task.
///
/// This widget displays a text field where the user can input a task description.
/// It uses [DescriptionAddTaskCubit] to manage the description state.
class DescriptionAddTask extends StatelessWidget {
  const DescriptionAddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DescriptionAddTaskCubit, String?>(
      builder: (context, state) {
        return CustomTextField(
          labelText: DescriptionAddTaskConstants.labelText,
          hintText: DescriptionAddTaskConstants.hintText,
          onChanged: (value) => _onDescriptionChanged(context, value),
        );
      },
    );
  }

  void _onDescriptionChanged(BuildContext context, String value) {
    BlocProvider.of<DescriptionAddTaskCubit>(context).updateDescription(value);
  }
}
