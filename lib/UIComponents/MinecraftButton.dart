import 'package:flutter/material.dart';

class MinecraftButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final bool large;

  const MinecraftButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF8B4513),
    this.large = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
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
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: large ? 32 : 24,
              vertical: large ? 16 : 12,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: large ? 20 : 16,
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
      ),
    );
  }
}