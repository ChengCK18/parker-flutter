import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalVehicleRegField extends StatefulWidget {
  const PersonalVehicleRegField({Key? key}) : super(key: key);

  @override
  State<PersonalVehicleRegField> createState() =>
      _PersonalVehicleRegFieldState();
}

class _PersonalVehicleRegFieldState extends State<PersonalVehicleRegField> {
  final personalVehicleNumPlateControl = TextEditingController(text: "None");

  CollectionReference vechicle = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    print('daaaaaa  ${personalVehicleNumPlateControl}');
    // Call the user's CollectionReference to add a new user
    return vechicle
        .add({
          'PlateNum': '${personalVehicleNumPlateControl.text}',
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    personalVehicleNumPlateControl.dispose();
    super.dispose();
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
                  controller: personalVehicleNumPlateControl,
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

                    labelText: 'Personal Vehicle',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('addddd');
                  addUser();
                },
                child:
                    Icon(Icons.app_registration_rounded, color: Colors.white),
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
