import 'package:flutter/material.dart';

class CustomRefreshButton extends StatelessWidget {
  const CustomRefreshButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
                    child: IconButton(
                        onPressed: onPressed, icon: Icon(Icons.refresh_outlined, size: 30,)),
                  );
  }
}