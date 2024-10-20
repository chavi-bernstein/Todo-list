import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_list/core/errors/failure.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';

abstract class TodoRepository {
  // Retrieves the list of todo tasks.
  Future<Either<Failure, List<Task>>> getTodoList();

  // Adds a new task to the todo list.
  Future<Either<Failure, Task>> addTask(Task task);

  // Deletes a task from the todo list.
  Future<Either<Failure, Task>> deleteTask(Task task);

  // Updates the completion status of a task.
  Future<Either<Failure, Task>> setCompletedTask(Task task, bool isCompleted);
}
