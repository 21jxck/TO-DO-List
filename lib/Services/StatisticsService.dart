import '../models/TodoList.dart';
import '../models/TodoItem.dart';

class StatisticsService {
  // Calcola il totale di task
  int getTotalItems(List<TodoList> lists) {
    int total = 0;
    for (var list in lists) {
      total += list.items.length;
    }
    return total;
  }

  // Calcola i task completati
  int getCompletedItems(List<TodoList> lists) {
    int completed = 0;
    for (var list in lists) {
      for (var item in list.items) {
        if (item.isCompleted) {
          completed++;
        }
      }
    }
    return completed;
  }

  // Calcola i task da fare
  int getPendingItems(List<TodoList> lists) {
    return getTotalItems(lists) - getCompletedItems(lists);
  }

  // Calcola l'efficienza globale (percentuale)
  double getEfficiency(List<TodoList> lists) {
    int total = getTotalItems(lists);
    if (total == 0) return 0.0;
    int completed = getCompletedItems(lists);
    return (completed / total) * 100;
  }

  // Calcola statistiche per una singola lista
  Map<String, dynamic> getListStats(TodoList list) {
    int total = list.items.length;
    int completed = 0;

    for (var item in list.items) {
      if (item.isCompleted) {
        completed++;
      }
    }

    int pending = total - completed;
    double efficiency = total == 0 ? 0.0 : (completed / total) * 100;

    return {
      'total': total,
      'completed': completed,
      'pending': pending,
      'efficiency': efficiency,
    };
  }
}