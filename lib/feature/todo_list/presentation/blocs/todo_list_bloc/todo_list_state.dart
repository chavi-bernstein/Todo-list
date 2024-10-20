import 'package:equatable/equatable.dart';
import 'package:todo_list/feature/todo_list/domain/entities/task.dart';

abstract class TodoListState extends Equatable {}

class TodoListLoading extends TodoListState {
  @override
  List<Object?> get props => [];
}

class EmptyTodoList extends TodoListState {
  @override
  List<Object?> get props => [];
}

class TodoListLoaded extends TodoListState {
  TodoListLoaded({
    required this.tasks
  });

  final List<Task> tasks;

  @override
  List<Object?> get props => [List.of(tasks)];
}


class TodoListFailed extends TodoListState {
  TodoListFailed({
    required this.message
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
