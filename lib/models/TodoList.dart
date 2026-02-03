import 'TodoItem.dart';

class TodoList {
  String id;
  String name;
  List<TodoItem> items;

  TodoList({
    required this.id,
    required this.name,
    List<TodoItem>? items,
  }) : items = items ?? [];
}