import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/components/custom_app_bar.dart';
import 'package:todo_list/core/components/custom_filled_button.dart';
import 'package:todo_list/core/utils/guide_line.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';
import 'package:todo_list/feature/todo_list/domain/enums/priority.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/add_task_cubits/deadline_add_task_cubit.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/add_task_cubits/description_add_task_cubit.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/add_task_cubits/priority_add_task_cubit.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/add_task_cubits/title_add_task_cubit.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/form_fields/deadline_add_task.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/form_fields/description_add_task.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/form_fields/priority_add_task.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/form_fields/title_add_task.dart';

class AddTaskScreenConstants {
  static const String appBarTitle = 'Todo list';
  static const String add = 'Add';
  static const String snackBarMessage = 'Task added successfully!';
  static const double topButtonSpace = 20;
}

/// Screen that provides functionality for adding a task.
///
/// This screen uses multiple `BlocProvider`s to manage different fields
/// (title, description, priority, deadline) and allows the user to submit
/// a new task to the list.
class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return const CustomAppBar(
      title: AddTaskScreenConstants.appBarTitle,
    );
  }

  // Builds the body of the screen, setting up the `MultiBlocProvider`
  // to provide the cubits that manage the task fields.
  Widget _buildBody(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TitleAddTaskCubit>(
          create: (context) => TitleAddTaskCubit(),
        ),
        BlocProvider<DescriptionAddTaskCubit>(
          create: (context) => DescriptionAddTaskCubit(),
        ),
        BlocProvider<PriorityAddTaskCubit>(
          create: (context) => PriorityAddTaskCubit(),
        ),
        BlocProvider<DeadlineAddTaskCubit>(
          create: (context) => DeadlineAddTaskCubit(),
        ),
      ],
      child: _buildForm(),
    );
  }

  Widget _buildForm() {
    final formKey = GlobalKey<FormState>();

    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GuideLine.horizontalPaddingScreen,
            vertical: GuideLine.verticalPaddingScreen,
          ),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(child: Container()),
                  const TitleAddTask(),
                  const DescriptionAddTask(),
                  const PriorityAddTask(),
                  const DeadlineAddTask(),
                  const SizedBox(
                    height: AddTaskScreenConstants.topButtonSpace,
                  ),
                  _buildButton(context, formKey),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Builds the button for submitting the form.
  Widget _buildButton(BuildContext context, GlobalKey<FormState> formKey) {
    return CustomFilledButton(
      onPressed: () => _addTask(context, formKey),
      text: AddTaskScreenConstants.add,
    );
  }

  // Validates the form and, if valid, creates a new task and adds it to the task list.
  //
  // This method checks the current state of the form using the provided [formKey].
  // If the form is valid, it retrieves the state from the corresponding cubits
  // (title, description, deadline, and priority) to create a new [Task].
  // Then, it triggers the [AddTask] event in the [TodoListBloc] to add the task
  // to the list. A snack bar is shown to confirm the addition,
  // and the screen is closed to return to the previous one.
  void _addTask(BuildContext context, GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      final newTask = Task(
        title: BlocProvider.of<TitleAddTaskCubit>(context).state,
        creationDate: DateTime.now(),
        description: BlocProvider.of<DescriptionAddTaskCubit>(context).state,
        deadline: BlocProvider.of<DeadlineAddTaskCubit>(context).state,
        priority: BlocProvider.of<PriorityAddTaskCubit>(context).state ??
            Priority.low,
      );

      // Trigger the event to add the task to the bloc
      BlocProvider.of<TodoListBloc>(context).add(
        AddTask(task: newTask),
      );

      _showSnackBar(context);

      // Navigate back to the previous screen after adding the task.
      Navigator.pop(context);
    }
  }

  // Shows a snack bar with a confirmation message after adding the task.
  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AddTaskScreenConstants.snackBarMessage),
      ),
    );
  }
}
