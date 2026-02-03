import 'package:flutter/material.dart';
import '../models/TodoManager.dart';
import 'ListDetailScreen.dart';
import 'MinecraftButton.dart';

class ListsScreen extends StatefulWidget {
  final TodoManager manager;

  const ListsScreen({Key? key, required this.manager}) : super(key: key);

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
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
    return Column(
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
            child: Text(
              '⛏️ LE MIE LISTE ⛏️',
              textAlign: TextAlign.center,
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
          ),
        ),
        Expanded(
          child: widget.manager.lists.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '📦',
                  style: TextStyle(fontSize: 80),
                ),
                const SizedBox(height: 24),
                Text(
                  'NESSUNA LISTA',
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
                const SizedBox(height: 32),
                MinecraftButton(
                  text: 'CREA NUOVA LISTA',
                  onPressed: _showAddListDialog,
                  large: true,
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: widget.manager.lists.length,
            itemBuilder: (context, index) {
              final list = widget.manager.lists[index];
              final stats = widget.manager.getListStats(list.id);

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B4513),
                  border: Border.all(color: Colors.black, width: 3),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ListDetailScreen(
                            list: list,
                            manager: widget.manager,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color:
                                        Colors.black.withOpacity(0.8),
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${list.items.length} task - ${stats['completed']} ✓',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    shadows: [
                                      Shadow(
                                        color:
                                        Colors.black.withOpacity(0.8),
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.manager.lists.length > 1)
                            IconButton(
                              icon: const Text('🗑️',
                                  style: TextStyle(fontSize: 24)),
                              onPressed: () => _confirmDelete(list.id),
                            ),
                          const Text('▶️',
                              style: TextStyle(fontSize: 24)),
                        ],
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
            text: '+ NUOVA LISTA',
            onPressed: _showAddListDialog,
            large: true,
            color: const Color(0xFF2E7D32),
          ),
        ),
      ],
    );
  }

  void _showAddListDialog() {
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
                'NUOVA LISTA',
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
                    hintText: 'Nome lista...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  autofocus: true,
                  style: const TextStyle(fontSize: 16),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      widget.manager.addList(value.trim());
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
                    text: 'CREA',
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        widget.manager.addList(controller.text.trim());
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

  void _confirmDelete(String listId) {
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
              const Text(
                '🗑️',
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                'ELIMINA LISTA?',
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
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MinecraftButton(
                    text: 'NO',
                    onPressed: () => Navigator.pop(dialogContext),
                    color: const Color(0xFF2E7D32),
                  ),
                  MinecraftButton(
                    text: 'SÌ',
                    onPressed: () {
                      widget.manager.deleteList(listId);
                      Navigator.pop(dialogContext);
                    },
                    color: Colors.red[800]!,
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
