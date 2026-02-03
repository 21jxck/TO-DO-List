import 'package:flutter/material.dart';
import '../models/TodoList.dart';
import '../models/TodoManager.dart';

class StatsScreen extends StatefulWidget {
  final TodoManager manager;

  const StatsScreen({Key? key, required this.manager}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
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
              '📊 STATISTICHE 📊',
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
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildGlobalStats(),
              const SizedBox(height: 24),
              Text(
                '📋 STATS PER LISTA',
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
              const SizedBox(height: 16),
              if (widget.manager.lists.isEmpty)
                Center(
                  child: Text(
                    'Nessuna lista ancora!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ...widget.manager.lists.map((list) => _buildListStats(list)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlobalStats() {
    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🌍 STATS GLOBALI',
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
          const SizedBox(height: 16),
          _buildStatRow('⚡ Task Totali', widget.manager.getTotalItems()),
          _buildStatRow('✅ Completati', widget.manager.getCompletedItems()),
          _buildStatRow('⏳ Da Fare', widget.manager.getPendingItems()),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF654321),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '🏆 EFFICIENZA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.8),
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${widget.manager.getEfficiency().toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: _getEfficiencyColor(widget.manager.getEfficiency()),
                    fontSize: 28,
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
          ),
        ],
      ),
    );
  }

  Widget _buildListStats(TodoList list) {
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            list.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.8),
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn('📦', stats['total']),
              _buildStatColumn('✅', stats['completed']),
              _buildStatColumn('⏳', stats['pending']),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF654321),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Stack(
              children: [
                if (stats['total'] > 0)
                  FractionallySizedBox(
                    widthFactor: stats['completed'] / stats['total'],
                    child: Container(
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '🏆 Efficienza: ${stats['efficiency'].toStringAsFixed(1)}%',
            style: TextStyle(
              color: _getEfficiencyColor(stats['efficiency']),
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.8),
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.8),
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
          Text(
            value.toString(),
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
        ],
      ),
    );
  }

  Widget _buildStatColumn(String emoji, int value) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 4),
        Text(
          value.toString(),
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
    );
  }

  Color _getEfficiencyColor(double efficiency) {
    if (efficiency >= 75) return const Color(0xFF2E7D32);
    if (efficiency >= 50) return const Color(0xFFFFA000);
    return Colors.red[700]!;
  }
}