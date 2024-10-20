import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/feature/todo_list/domain/enums/priority.dart';

/// Manages the priority selection for the task being added in the form.
///
/// The [PriorityAddTaskCubit] is used to handle the state of the priority field
/// in the "Add Task" screen. It allows updating the task's priority and emitting
/// its value, which will be used when creating a new task.
class PriorityAddTaskCubit extends Cubit<Priority?> {
  PriorityAddTaskCubit() : super(null);

  /// Updates the task priority by emitting the new [priority] selected by the user.
  void updatePriority(Priority? priority) {
    emit(priority);
  }
}
