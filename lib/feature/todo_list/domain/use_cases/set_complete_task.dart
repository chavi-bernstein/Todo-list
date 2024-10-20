import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_list/core/errors/failure.dart';
import 'package:todo_list/core/utils/use_case.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';
import 'package:todo_list/feature/todo_list/domain/repositories/todo_repository.dart';

/// A use case for setting the completion status of a task.
class SetCompleteTaskUseCase
    implements UseCase<Task, SetCompleteTaskUseCaseParams> {
  final TodoRepository repository;

  const SetCompleteTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, Task>> call(
      {required SetCompleteTaskUseCaseParams params}) async {
    return await repository.setCompletedTask(params.task, params.isCompleted);
  }
}

class SetCompleteTaskUseCaseParams {
  const SetCompleteTaskUseCaseParams({
    required this.task,
    required this.isCompleted,
  });

  final Task task;
  final bool isCompleted;
}
