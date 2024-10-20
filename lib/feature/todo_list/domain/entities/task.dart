import 'package:todo_list/feature/todo_list/domain/enums/priority.dart';
import 'package:uuid/uuid.dart';

class Task {
  Task({
    required this.title,
    this.isCompleted = false,
    required this.creationDate,
    this.description,
    this.deadline,
    this.priority = Priority.low,
  }) : id = const Uuid().v4();

  /// A unique identifier for the task.
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime creationDate;
  final String? description;
  final DateTime? deadline;
  final Priority priority;

  Task copyWith({
    String? title,
    bool? isCompleted,
    DateTime? creationDate,
    String? description,
    DateTime? deadline,
    Priority? priority,
  }) {
    return Task(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      creationDate: creationDate ?? this.creationDate,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
    );
  }
}
