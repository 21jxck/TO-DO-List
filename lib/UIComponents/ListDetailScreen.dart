import 'package:flutter/material.dart';
import '../models/TodoList.dart';
import '../models/TodoManager.dart';
import 'MinecraftButton.dart';

class ListDetailScreen extends StatefulWidget {
  final TodoList list;
  final TodoManager manager;

  const ListDetailScreen({
    Key? key,
    required this.list,
    required this.manager,
  }) : super(key: key);

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  @override
  void initState() {
    super.initState();
    widget.manager.addListener(_onUpdate);
  }

  @override
  void dispose() {
    widget.manager.removeListener(_onUpdate);
    super.dispose();
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentList = widget.manager.lists.firstWhere(
          (l) => l.id == widget.list.id,
      orElse: () => widget.list,
    );

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF87CEEB), Color(0xFF7CB342)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF654321),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 3),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Text('◀️', style: TextStyle(fontSize: 24)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        widget.list.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.8),
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
            Expanded(
              child: currentList.items.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('📝', style: TextStyle(fontSize: 80)),
                    const SizedBox(height: 24),
                    Text(
                      'NESSUN TASK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.8),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: currentList.items.length,
                itemBuilder: (context, index) {
                  final item = currentList.items[index];

                  return Dismissible(
                    key: Key(item.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red[800],
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Text('🗑️',
                          style: TextStyle(fontSize: 32)),
                    ),
                    onDismissed: (_) {
                      widget.manager
                          .deleteItem(widget.list.id, item.id);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: item.isCompleted
                            ? const Color(0xFF4A4A4A)
                            : const Color(0xFF8B4513),
                        border:
                        Border.all(color: Colors.black, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            widget.manager
                                .toggleItem(widget.list.id, item.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  item.isCompleted ? '✅' : '⬜',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      decoration: item.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black
                                              .withOpacity(0.8),
                                          offset: const Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: MinecraftButton(
                text: '+ NUOVO TASK',
                onPressed: _showAddTaskDialog,
                large: true,
                color: const Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: const Color(0xFF8B4513),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: const BorderSide(color: Colors.black, width: 3),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'NUOVO TASK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.8),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Descrizione task...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  autofocus: true,
                  style: const TextStyle(fontSize: 16),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      widget.manager.addItem(widget.list.id, value.trim());
                      Navigator.pop(dialogContext);
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MinecraftButton(
                    text: 'ANNULLA',
                    onPressed: () => Navigator.pop(dialogContext),
                    color: Colors.red[800]!,
                  ),
                  MinecraftButton(
                    text: 'AGGIUNGI',
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        widget.manager
                            .addItem(widget.list.id, controller.text.trim());
                        Navigator.pop(dialogContext);
                      }
                    },
                    color: const Color(0xFF2E7D32),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
