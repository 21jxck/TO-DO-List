import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/TodoItem.dart';
import '../models/TodoList.dart';

class StorageService {
  static const String _listsKey = 'todo_lists';

  // Salva tutte le liste
  Future<void> saveLists(List<TodoList> lists) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = lists.map((list) => {
      'id': list.id,
      'name': list.name,
      'items': list.items.map((item) => {
        'id': item.id,
        'title': item.title,
        'isCompleted': item.isCompleted,
      }).toList(),
    }).toList();

    await prefs.setString(_listsKey, jsonEncode(jsonList));
    print('Dati salvati: $jsonList');
  }

  // Carica tutte le liste
  Future<List<TodoList>> loadLists() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_listsKey);

    print('Dati carichi: $jsonString');

    if (jsonString == null || jsonString.isEmpty) return [];

    try {
      final jsonList = jsonDecode(jsonString);

      // Converti a List<Map<String, dynamic>>
      final List<TodoList> lists = [];

      for (var listJson in jsonList) {
        final listMap = Map<String, dynamic>.from(listJson);

        // Converti items
        final itemsList = <TodoItem>[];
        final itemsJson = listMap['items'] as List;

        for (var itemJson in itemsJson) {
          final itemMap = Map<String, dynamic>.from(itemJson);
          itemsList.add(
            TodoItem(
              id: itemMap['id'].toString(),
              title: itemMap['title'].toString(),
              isCompleted: itemMap['isCompleted'] == true,
            ),
          );
        }

        lists.add(
          TodoList(
            id: listMap['id'].toString(),
            name: listMap['name'].toString(),
            items: itemsList,
          ),
        );
      }

      return lists;
    } catch (e) {
      print('Errore nel caricamento: $e');
      return [];
    }
  }

  // Cancella tutti i dati
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_listsKey);
  }
}