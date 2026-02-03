import 'package:flutter/material.dart';
import '../models/TodoManager.dart';
import 'ListsScreen.dart';
import 'StatsScreen.dart';

class MainScreen extends StatefulWidget {
  final TodoManager manager;

  const MainScreen({Key? key, required this.manager}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      ListsScreen(manager: widget.manager),
      StatsScreen(manager: widget.manager),
    ];

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
        body: screens[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF654321),
            border: Border(
              top: BorderSide(color: Colors.black, width: 3),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildNavButton(
                  icon: '📋',
                  label: 'LISTE',
                  isSelected: _currentIndex == 0,
                  onTap: () => setState(() => _currentIndex = 0),
                ),
              ),
              Container(width: 3, height: 60, color: Colors.black),
              Expanded(
                child: _buildNavButton(
                  icon: '📊',
                  label: 'STATS',
                  isSelected: _currentIndex == 1,
                  onTap: () => setState(() => _currentIndex = 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required String icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isSelected ? const Color(0xFF8B4513) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
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
        ),
      ),
    );
  }
}