import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/components/custom_app_bar.dart';
import 'package:todo_list/core/utils/guide_line.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_state.dart';
import 'package:todo_list/feature/todo_list/presentation/pages/add_task_screen.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/empty_list.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/error_list.dart';
import 'package:todo_list/feature/todo_list/presentation/widgets/task_card.dart';

class TodoListScreenConstants {
  static const String appBarTitle = 'Todo list';
}

/// Screen that displays the list of tasks.
///
/// This screen uses [TodoListBloc] to manage the state of the list.
/// It fetches the tasks on build and displays them in a list format.
/// Users can add new tasks by pressing the floating action button.
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    _getTasks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return const CustomAppBar(
      title: TodoListScreenConstants.appBarTitle,
    );
  }

  // Builds the body of the screen based on the current state of the list.
  Widget _buildBody(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoListState>(
      builder: (context, state) {
        if (state is TodoListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodoListFailed) {
          return ErrorList(
            onRetry: () => _getTasks(context),
          );
        } else if (state is EmptyTodoList) {
          return EmptyList(
            onAddTask: () => _onAddTaskPressed(context),
          );
        } else if (state is TodoListLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: GuideLine.horizontalPaddingScreen,
              vertical: GuideLine.verticalPaddingScreen,
            ),
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              return TaskCard(
                task: state.tasks[index],
              );
            },
          );
        }
        return Container();
      },
    );
  }

  // Builds the floating action button for adding a new task.
  Widget _buildFloatingActionButton() {
    return BlocBuilder<TodoListBloc, TodoListState>(
      builder: (context, state) {
        if (state is TodoListLoaded && state.tasks.isNotEmpty) {
          return FloatingActionButton(
            onPressed: () => _onAddTaskPressed(context),
            child: const Icon(Icons.add),
          );
        }
        return Container();
      },
    );
  }

  // Navigates to the [AddTaskScreen] when the add task button is pressed.
  void _onAddTaskPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTaskScreen(),
      ),
    );
  }

  void _getTasks(BuildContext context) {
    BlocProvider.of<TodoListBloc>(context).add(GetTodoList());
  }
}
