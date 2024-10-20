import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_list/core/errors/failure.dart';
import 'package:todo_list/core/utils/use_case.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';
import 'package:todo_list/feature/todo_list/domain/repositories/todo_repository.dart';

/// A use case for adding a task to the list.
class AddTaskUseCase implements UseCase<Task, AddTaskParams> {
  final TodoRepository repository;

  const AddTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, Task>> call({required AddTaskParams params}) async {
    return await repository.addTask(params.task);
  }
}

class AddTaskParams {
  const AddTaskParams({required this.task});

  final Task task;
}
