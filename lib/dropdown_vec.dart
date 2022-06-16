import 'package:flutter/material.dart';

class DropdownVec extends StatefulWidget {
  const DropdownVec({Key? key}) : super(key: key);
  final Color color1 = Colors.greenAccent;
  final Color color2 = Colors.cyan;
  @override
  State<DropdownVec> createState() => _DropdownVecState();
}

class _DropdownVecState extends State<DropdownVec>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 4, end: 16).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: 48,
      width: 160,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              widget.color1,
              widget.color2,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: widget.color1.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: animation.value,
              offset: Offset(-8, 0),
            ),
            BoxShadow(
              color: widget.color2.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: animation.value,
              offset: Offset(8, 0),
            ),
            BoxShadow(
              color: widget.color1.withOpacity(0.2),
              spreadRadius: 16,
              blurRadius: 32,
              offset: Offset(-8, 0),
            ),
            BoxShadow(
              color: widget.color2.withOpacity(0.2),
              spreadRadius: 16,
              blurRadius: 32,
              offset: Offset(8, 0),
            )
          ]),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
