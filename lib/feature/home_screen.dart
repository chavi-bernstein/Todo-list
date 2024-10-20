import 'package:flutter/material.dart';
import 'package:todo_list/core/components/custom_app_bar.dart';
import 'package:todo_list/core/components/custom_filled_button.dart';
import 'package:todo_list/feature/todo_list/presentation/pages/todo_list_screen.dart';

class HomeScreenConstants {
  static const String title = "Home screen";
  static const String welcome = "Welcome";
  static const String showList = "Show list";
  static const double spaceBetweenTextToButton = 50;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: HomeScreenConstants.title,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWelcomeText(context),
            const SizedBox(
              height: HomeScreenConstants.spaceBetweenTextToButton,
            ),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Text(
      HomeScreenConstants.welcome,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _buildButton(BuildContext context) {
    return CustomFilledButton(
      onPressed: () => _onPressed(context),
      text: HomeScreenConstants.showList,
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TodoListScreen(),
      ),
    );
  }
}
