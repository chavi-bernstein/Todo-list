import 'package:todo_list/feature/todo_list/data/data_source/local/todo_local_data_source.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';

class TodoLocalCache {
  List<Task>? todoItems;
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  TodoLocalCache cache = TodoLocalCache();

  @override
  List<Task> getTodoList() {
    return cache.todoItems ?? [];
  }

  @override
  Task addTask(Task task) {
    cache.todoItems != null && cache.todoItems!.isNotEmpty
        ? cache.todoItems!.add(task)
        : cache.todoItems = [task];

    return task;
  }

  @override
  Task deleteTask(Task task) {
    cache.todoItems != null && cache.todoItems!.isNotEmpty
        ? cache.todoItems!.remove(task)
        : null;

    return task;
  }

  @override
  Task setCompletedTask(Task task, bool isCompleted) {
    Task updatedItem = task.copyWith(isCompleted: isCompleted);

    if (cache.todoItems != null) {
      int index = cache.todoItems!.indexWhere((todo) => todo.id == task.id);
      if (index != -1) {
        cache.todoItems![index] = updatedItem;
      }
    }

    return updatedItem;
  }
}
