import 'package:todo_list/feature/todo_list/domain/entities/task.dart';

abstract class TodoLocalDataSource {
  // Retrieves the tasks list.
  List<Task> getTodoList();

  // Adds a new task to the list.
  Task addTask(Task task);

  // Deletes a task from the list.
  Task deleteTask(Task task);

  // Updates the completion status of a task.
  Task setCompletedTask(Task task, bool isCompleted);
}
