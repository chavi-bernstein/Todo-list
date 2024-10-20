import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_list/core/errors/failure.dart';
import 'package:todo_list/feature/todo_list/data/data_source/local/todo_local_data_source.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';
import 'package:todo_list/feature/todo_list/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl(this.localDataSource);

  final TodoLocalDataSource localDataSource;

  @override
  Future<Either<Failure, Task>> addTask(Task task) async {
    try {
      final result = localDataSource.addTask(task);
      return Right(result);
    } catch (e) {
      return Left(Failure("Error adding task: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Task>> deleteTask(Task task) async {
    try {
      final result = localDataSource.deleteTask(task);
      return Right(result);
    } catch (e) {
      return Left(Failure("Error deleting task: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTodoList() async {
    try {
      final tasks = localDataSource.getTodoList();
      return Right(tasks);
    } catch (e) {
      return Left(Failure("Error fetching tasks: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Task>> setCompletedTask(
      Task task, bool isCompleted) async {
    try {
      final completedItem = localDataSource.setCompletedTask(task, isCompleted);
      return Right(completedItem);
    } catch (e) {
      return Left(Failure("Error edit task: ${e.toString()}"));
    }
  }
}
