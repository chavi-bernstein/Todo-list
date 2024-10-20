import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/feature/todo_list/domain/use_cases/add_task.dart';
import 'package:todo_list/feature/todo_list/domain/use_cases/delete_task.dart';
import 'package:todo_list/feature/todo_list/domain/use_cases/get_todo_list.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_state.dart';

/// Bloc responsible for managing the to-do list actions such as fetching, adding, and deleting tasks.
///
/// [TodoListBloc] listens to events like [GetTodoList], [AddTask], and [DeleteTask],
/// and updates the state of the to-do list accordingly.
class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListLoading()) {
    on<GetTodoList>(_onGetTodoList);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
  }

  final GetTodoListUseCase _getTodoItemsUseCase =
      GetIt.instance<GetTodoListUseCase>();
  final AddTaskUseCase _addTaskUseCase = GetIt.instance<AddTaskUseCase>();
  final DeleteTaskUseCase _deleteTaskUseCase =
      GetIt.instance<DeleteTaskUseCase>();

  /// Handles the [GetTodoList] event by fetching the current list of tasks.
  Future<void> _onGetTodoList(
      GetTodoList event, Emitter<TodoListState> emit) async {
    emit(TodoListLoading());
    final result = await _getTodoItemsUseCase(params: NoParams());
    result.fold(
      (failure) => emit(
        TodoListFailed(message: failure.message),
      ),
      (tasks) => emit(
        tasks.isEmpty ? EmptyTodoList() : TodoListLoaded(tasks: tasks),
      ),
    );
  }

  /// Handles the [AddTask] event by adding a new task to the list.
  /// After adding the task, the to-do list is refreshed by calling [_onGetTodoList].
  Future<void> _onAddTask(AddTask event, Emitter<TodoListState> emit) async {
    emit(TodoListLoading());

    final result = await _addTaskUseCase(
      params: AddTaskParams(task: event.task),
    );

    await result.fold(
      (failure) async => emit(TodoListFailed(message: failure.message)),
      (item) async {
        final fetchResult = await _getTodoItemsUseCase(params: NoParams());
        fetchResult.fold(
          (failure) => emit(TodoListFailed(message: failure.message)),
          (tasks) => emit(TodoListLoaded(tasks: tasks)),
        );
      },
    );
  }

  /// Handles the [DeleteTask] event by removing a task from the list.
  /// After deletion, the to-do list is refreshed by calling [_onGetTodoList].
  Future<void> _onDeleteTask(
      DeleteTask event, Emitter<TodoListState> emit) async {
    emit(TodoListLoading());
    final result = await _deleteTaskUseCase(
      params: DeleteTaskParams(task: event.task),
    );

    await result.fold(
      (failure) async => emit(
        TodoListFailed(message: failure.message),
      ),
      (item) async {
        final fetchResult = await _getTodoItemsUseCase(
          params: NoParams(),
        );

        await fetchResult.fold(
          (failure) async => emit(
            TodoListFailed(message: failure.message),
          ),
          (tasks) async => emit(
            tasks.isEmpty ? EmptyTodoList() : TodoListLoaded(tasks: tasks),
          ),
        );
      },
    );
  }
}
