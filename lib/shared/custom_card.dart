// Simple custom card widget
// Reusable card for displaying content

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? padding;
  final Color? backgroundColor;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = 16,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
