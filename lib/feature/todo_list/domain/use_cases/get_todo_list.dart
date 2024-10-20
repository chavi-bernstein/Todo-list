import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_list/core/errors/failure.dart';
import 'package:todo_list/core/utils/use_case.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';
import 'package:todo_list/feature/todo_list/domain/repositories/todo_repository.dart';

/// A use case for retrieving the list of tasks from the repository.
///
/// This class handles the logic of fetching the tasks list and sorting it
/// by the creation date of each task.
class GetTodoListUseCase implements UseCase<List<Task>, NoParams> {
  final TodoRepository repository;

  const GetTodoListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Task>>> call({required NoParams params}) async {
    final result = await repository.getTodoList();

    return result.fold(
      (failure) => Left(failure),
      (tasks) => Right(
        sortTasksByCreateDate(tasks),
      ),
    );
  }

  // Sorts the list by their creation date, placing the newest tasks first.
  List<Task> sortTasksByCreateDate(List<Task> tasks) {
    tasks.sort(
      (a, b) => b.creationDate.compareTo(a.creationDate),
    );

    return tasks;
  }
}

class NoParams {}
