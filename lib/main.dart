import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:todo_list/core/utils/service_locator.dart';
import 'package:todo_list/feature/home_screen.dart';
import 'package:todo_list/feature/todo_list/presentation/blocs/todo_list_bloc/todo_list_bloc.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Preserve the native splash screen while the app is initializing
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Sets up the service locator for dependency injection.
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    // Providing TodoListBloc to the widget tree.
    // The bloc is placed at this height in the tree because Navigator.
    // push uses the context of MaterialApp.
    return BlocProvider<TodoListBloc>(
      create: (context) => TodoListBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
