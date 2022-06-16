import 'package:flutter/material.dart';

class ControlVec extends StatefulWidget {
  const ControlVec({Key? key}) : super(key: key);

  @override
  State<ControlVec> createState() => _ControlVecState();
}

class _ControlVecState extends State<ControlVec>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Container 2"));
  }
}
