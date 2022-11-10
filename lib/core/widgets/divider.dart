import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final Color color;
  const AppDivider({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        height: 3,
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
