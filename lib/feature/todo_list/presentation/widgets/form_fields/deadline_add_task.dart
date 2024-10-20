import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/utils/date_helper.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/add_task_cubits/deadline_add_task_cubit.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/form_fields/custom_text_field.dart';

class DeadlineAddTaskConstants {
  static const String labelText = 'Deadline';
  static const String hintText = 'Select a date';
}

/// A widget that allows the user to select a deadline date for a task.
///
/// This widget displays a text field with a calendar icon that opens a date picker
/// to select a date. It uses [DeadlineAddTaskCubit] to manage the selected date state.
class DeadlineAddTask extends StatelessWidget {
  const DeadlineAddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeadlineAddTaskCubit, DateTime?>(
      builder: (context, state) {
        return CustomTextField(
          labelText: DeadlineAddTaskConstants.labelText,
          hintText: DeadlineAddTaskConstants.hintText,
          readonly: true,
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDeadline(context, state),
          ),
          controller: TextEditingController(
            text: state != null ? DateHelper.getDateFormat(state) : '',
          ),
        );
      },
    );
  }

  // Opens a date picker dialog to select a deadline date.
  //
  // The [selectedDate] parameter is used to initialize the date picker.
  // If a new date is selected, it updates the deadline
  Future<void> _selectDeadline(
      BuildContext context, DateTime? selectedDate) async {
    final DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null && picked != selectedDate) {
      if (context.mounted) {
        BlocProvider.of<DeadlineAddTaskCubit>(context).updateDeadline(picked);
      }
    }
  }
}
