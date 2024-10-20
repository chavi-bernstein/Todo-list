import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_list/core/errors/failure.dart';
import 'package:todo_list/core/utils/use_case.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';
import 'package:todo_list/feature/todo_list/domain/repositories/todo_repository.dart';

/// A use case for deleting a task to the list.
class DeleteTaskUseCase implements UseCase<Task, DeleteTaskParams> {
  final TodoRepository repository;

  const DeleteTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, Task>> call({required DeleteTaskParams params}) async {
    return await repository.deleteTask(params.task);
  }
}

class DeleteTaskParams {
  const DeleteTaskParams({required this.task});

  final Task task;
}
