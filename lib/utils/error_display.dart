import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String error;
  const ErrorDisplay({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          error,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
