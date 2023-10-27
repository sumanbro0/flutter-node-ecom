import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double size;
  const Gap({super.key, this.size = 0.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 16 + size, width: 16 + size);
  }
}
