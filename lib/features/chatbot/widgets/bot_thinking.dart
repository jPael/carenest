import 'package:flutter/material.dart';

class Thinking extends StatefulWidget {
  const Thinking({super.key});

  @override
  State<Thinking> createState() => _ThinkingState();
}

class _ThinkingState extends State<Thinking> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = IntTween(begin: 0, end: 3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String dots = '.' * (_animation.value + 1);
        return Text(
          'Thinking$dots',
          style: TextStyle(fontSize: 16, color: Colors.black),
        );
      },
    );
  }
}
