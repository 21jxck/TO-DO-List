class TodoItem {
  String id;
  String title;
  bool isCompleted;
  DateTime? createdAt;

  TodoItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.createdAt,
  });
}