import 'package:flutter/material.dart';

class TargetVehicleNotifyField extends StatefulWidget {
  const TargetVehicleNotifyField(
      {Key? key, required this.targetVehicleNumPlateControl})
      : super(key: key);
  final TextEditingController targetVehicleNumPlateControl;

  @override
  State<TargetVehicleNotifyField> createState() =>
      _TargetVehicleNotifyFieldState();
}

class _TargetVehicleNotifyFieldState extends State<TargetVehicleNotifyField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: TextFormField(
                  controller: widget.targetVehicleNumPlateControl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: true,
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    //[focusedBorder], displayed when [TextField, InputDecorator.isFocused] is true
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    labelText: 'Target Vehicle',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ]));
  }
}
