import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';
import 'package:todo_list/feature/todo_list/domain/use_cases/set_complete_task.dart';

/// A Cubit that manages the completion state of a task.
///
/// The [TaskCompletionCubit] handles toggling the completion status of a task
/// by using the [SetCompleteTaskUseCase] to persist the state change.
class TaskCompletionCubit extends Cubit<bool> {
  TaskCompletionCubit({required bool isCompleted}) : super(isCompleted);

  // The use case responsible for updating the completion status of a task.
  final SetCompleteTaskUseCase _setCompleteTaskUseCase =
      GetIt.instance<SetCompleteTaskUseCase>();

  /// Toggles the completion state of the given [task].
  ///
  /// This function calls the [SetCompleteTaskUseCase] to update the completion
  /// state of the task. If the update is successful, it emits the new state.
  Future<void> toggleComplete(Task task) async {
    final result = await _setCompleteTaskUseCase(
      params: SetCompleteTaskUseCaseParams(task: task, isCompleted: !state),
    );

    await result.fold(
      // On failure, keep the current state.
      (failure) async => emit(state),
      // On success, toggle the state.
      (item) async => emit(!state),
    );
  }
}
