import 'package:flutter/material.dart';
import '../Services/StatisticsService.dart';
import '../Services/StorageService.dart';
import 'TodoItem.dart';
import 'TodoList.dart';

class TodoManager extends ChangeNotifier {
  List<TodoList> lists = [];
  final StorageService _storage = StorageService();
  final StatisticsService _statistics = StatisticsService();

  // Carica i dati all'avvio
  Future<void> initialize() async {
    lists = await _storage.loadLists();
    notifyListeners();
  }

  void addList(String name) {
    lists.add(TodoList(id: DateTime.now().toString(), name: name));
    _save();
  }

  void addItem(String listId, String title) {
    final list = lists.firstWhere((l) => l.id == listId);
    list.items.add(TodoItem(
      id: DateTime.now().toString(),
      title: title,
    ));
    _save();
  }

  void toggleItem(String listId, String itemId) {
    final list = lists.firstWhere((l) => l.id == listId);
    final item = list.items.firstWhere((i) => i.id == itemId);
    item.isCompleted = !item.isCompleted;
    _save();
  }

  void deleteItem(String listId, String itemId) {
    final list = lists.firstWhere((l) => l.id == listId);
    list.items.removeWhere((i) => i.id == itemId);
    _save();
  }

  void deleteList(String listId) {
    lists.removeWhere((l) => l.id == listId);
    _save();
  }

  int getTotalItems() => _statistics.getTotalItems(lists);

  int getCompletedItems() => _statistics.getCompletedItems(lists);

  int getPendingItems() => _statistics.getPendingItems(lists);

  double getEfficiency() => _statistics.getEfficiency(lists);

  Map<String, dynamic> getListStats(String listId) {
    final list = lists.firstWhere((l) => l.id == listId);
    return _statistics.getListStats(list);
  }

  // Salva i dati dopo ogni modifica
  Future<void> _save() async {
    await _storage.saveLists(lists);
    notifyListeners();
  }
}