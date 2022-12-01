import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.black,
        ),
      ),
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Center(
        child: TextField(
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          style: const TextStyle(
            fontSize: 24,
          ),
          keyboardType: TextInputType.number,
          controller: controller,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
