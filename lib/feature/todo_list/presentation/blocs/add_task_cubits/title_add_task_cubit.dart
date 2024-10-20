import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages the title input for the task being added in the form.
///
/// The [TitleAddTaskCubit] is used to handle the state of the title field
/// in the "Add Task" screen. It allows updating the task title and emitting
/// its value, which will be used to create a new task.
class TitleAddTaskCubit extends Cubit<String> {
  TitleAddTaskCubit() : super('');

  /// Updates the task title by emitting the new [title] entered by the user.
  void updateTitle(String title) {
    emit(title);
  }
}
