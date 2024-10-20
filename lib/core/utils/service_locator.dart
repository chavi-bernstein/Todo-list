import 'package:get_it/get_it.dart';
import 'package:todo_list/feature/todo_list/data/data_source/local/todo_local_data_source.dart';
import 'package:todo_list/feature/todo_list/data/data_source/local/todo_local_data_source_impl.dart';
import 'package:todo_list/feature/todo_list/domain/repositories/todo_repository.dart';
import 'package:todo_list/feature/todo_list/data/repositories/todo_repository_impl.dart';
import 'package:todo_list/feature/todo_list/domain/use_cases/add_task.dart';
import 'package:todo_list/feature/todo_list/domain/use_cases/delete_task.dart';
import 'package:todo_list/feature/todo_list/domain/use_cases/get_todo_list.dart';
import 'package:todo_list/feature/todo_list/domain/use_cases/set_complete_task.dart';

/// Service locator for managing dependencies in the application.
///
/// This class sets up the GetIt service locator.
/// Registering the necessary dependencies such as data sources, repositories, and use cases.
final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Registering the local data source implementation.
  getIt.registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl());
  // Registering the repository implementation with the local data source dependency.

  getIt.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(getIt<TodoLocalDataSource>()));

  // Registering use cases with the repository dependency.
  getIt.registerLazySingleton<GetTodoListUseCase>(
      () => GetTodoListUseCase(repository: getIt<TodoRepository>()));
  getIt.registerLazySingleton<AddTaskUseCase>(
      () => AddTaskUseCase(repository: getIt<TodoRepository>()));
  getIt.registerLazySingleton<DeleteTaskUseCase>(
      () => DeleteTaskUseCase(repository: getIt<TodoRepository>()));
  getIt.registerLazySingleton<SetCompleteTaskUseCase>(
      () => SetCompleteTaskUseCase(repository: getIt<TodoRepository>()));
}
