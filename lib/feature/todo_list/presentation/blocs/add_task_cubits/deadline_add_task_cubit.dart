import 'package:flutter_bloc/flutter_bloc.dart';
/// Manages the deadline selection for the task being added in the form.
///
/// The [DeadlineAddTaskCubit] is used to handle the state of the deadline field
/// in the "Add Task" screen. It allows updating the task's deadline and emitting
/// its value, which will be used when creating a new task.
class DeadlineAddTaskCubit extends Cubit<DateTime?>{
  DeadlineAddTaskCubit(): super(null);

  /// Updates the task deadline by emitting the new [deadline] selected by the user.
  void updateDeadline(DateTime? deadline){
    emit(deadline);
  }

}