import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/add_task_cubits/title_add_task_cubit.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/form_fields/custom_text_field.dart';

class TitleAddTaskConstants {
  static const String labelText = 'Title';
  static const String hintText = 'Enter title';
  static const String validatorText = 'Please enter a title';
}

/// A widget that allows the user to enter a title for a task.
///
/// This widget displays a text field where the user can input a task title.
/// It uses [TitleAddTaskCubit] to manage the title state.
class TitleAddTask extends StatelessWidget {
  const TitleAddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TitleAddTaskCubit, String>(
      builder: (context, state) {
        return CustomTextField(
          labelText: TitleAddTaskConstants.labelText,
          hintText: TitleAddTaskConstants.hintText,
          validator: _getTitleValidator,
          onChanged: (value) => _onTitleChanged(context, value),
        );
      },
    );
  }

  String? _getTitleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TitleAddTaskConstants.validatorText;
    }
    return null;
  }

  void _onTitleChanged(BuildContext context, String value) {
    BlocProvider.of<TitleAddTaskCubit>(context).updateTitle(value);
  }
}
