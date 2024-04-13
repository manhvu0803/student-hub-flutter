import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 100),
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator()
        ),
      ],
    );
  }
}