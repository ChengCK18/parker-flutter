import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TargetVehicleNotifyField extends StatefulWidget {
  const TargetVehicleNotifyField({Key? key}) : super(key: key);

  @override
  State<TargetVehicleNotifyField> createState() =>
      _TargetVehicleNotifyFieldState();
}

class _TargetVehicleNotifyFieldState extends State<TargetVehicleNotifyField> {
  final targetVehicleNumPlateControl = TextEditingController(text: "None");

  void alertTargetVehicle(String targetNumPlate) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('vehicles')
        .doc("${targetVehicleNumPlateControl.text}")
        .get();

    if (snapShot.exists) {
      var collection = FirebaseFirestore.instance.collection('vehicles');
      collection
          .doc(
              "${targetVehicleNumPlateControl.text}") // <-- Doc ID where data should be updated.
          .update({
            'listener': FieldValue.arrayUnion(['another user here'])
          })
          .then((_) => print('Updated'))
          .catchError((error) => print('Update failed: $error'));
    } else {
      AlertDialog alert = AlertDialog(
        title: const Text("Woops, error"),
        content: Text("Target Vehicle is not registered on this platform."),
        actions: [
          TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                targetVehicleNumPlateControl.clear();
              }),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

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
                  controller: targetVehicleNumPlateControl,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
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
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.send, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                  primary: Colors.cyan, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
              )
            ]));
  }
}
