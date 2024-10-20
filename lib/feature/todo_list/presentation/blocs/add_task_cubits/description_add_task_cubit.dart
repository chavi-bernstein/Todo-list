import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages the description input for the task being added in the form.
///
/// The [DescriptionAddTaskCubit] is responsible for handling the state of the
/// description field in the "Add Task" screen. It allows updating and storing
/// the task's description, which will be used when creating a new task.
class DescriptionAddTaskCubit extends Cubit<String?> {
  DescriptionAddTaskCubit() : super(null);

  /// Updates the task description by emitting the new [description] entered by the user.
  void updateDescription(String? description) {
    emit(description);
  }
}
