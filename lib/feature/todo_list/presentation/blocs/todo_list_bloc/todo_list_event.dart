import 'package:equatable/equatable.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';

abstract class TodoListEvent extends Equatable {}

class GetTodoList extends TodoListEvent {
  @override
  List<Object?> get props => [];
}

class AddTask extends TodoListEvent {
  AddTask({
    required this.task
  });

  final Task task;

  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TodoListEvent {
  DeleteTask({
    required this.task
  });

  final Task task;

  @override
  List<Object?> get props => [task];
}