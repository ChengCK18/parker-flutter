import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalVehicleRegField extends StatefulWidget {
  const PersonalVehicleRegField(
      {Key? key,
      required this.userEmail,
      required this.updatePersonalVecAlertReceived,
      required this.updatePersonalVecNumPlate})
      : super(key: key);

  final String userEmail;
  final Function updatePersonalVecAlertReceived;
  final Function updatePersonalVecNumPlate;
  @override
  State<PersonalVehicleRegField> createState() =>
      _PersonalVehicleRegFieldState();
}

class _PersonalVehicleRegFieldState extends State<PersonalVehicleRegField> {
  var personalVehicleNumPlateControl = TextEditingController(text: "None");
  String registeredNumPlate = "";

  CollectionReference vehicle =
      FirebaseFirestore.instance.collection('vehicles');

  void registerVehicle() async {
    //Cannot reregister again the same registered vehicle
    if (personalVehicleNumPlateControl.text == registeredNumPlate) {
      return;
    }
    //remove user from other registered vehicle and add user to newly registered vehicle
    deregisterFromVehicles().then((value) {
      FirebaseFirestore.instance
          .collection('vehicles')
          .doc(personalVehicleNumPlateControl.text) // varuId in your case
          .get()
          .then((snapShot) {
        if (!snapShot.exists) {
          //Create new document only if there is no existing record of the vehicle
          vehicle.doc(personalVehicleNumPlateControl.text).set({
            "listener": [widget.userEmail],
            "reporter": [],
            "dateAdded": DateTime.now()
          }).then((value) {
            print("Added user to newly added vehicle");

            setState(() {
              registeredNumPlate = personalVehicleNumPlateControl.text;
            });
          }).catchError((error) => print("Failed to add Vehicle: $error"));
        } else {
          //Add user to existing vehicle
          var collection = FirebaseFirestore.instance.collection('vehicles');
          collection.doc(personalVehicleNumPlateControl.text).update({
            'listener': FieldValue.arrayUnion([widget.userEmail])
          }).then((_) {
            print('Added user to existing vehicle');
            setState(() {
              registeredNumPlate = personalVehicleNumPlateControl.text;
            });
          }).catchError((error) =>
              print('Adding user to existing vehicle failed: $error'));
        }
      });
    });
  }

  Future<void> deregisterFromVehicles() async {
    //To search for existing vehicle that was registered by user and remove user from it

    bool userRegistered = false;
    String userRegisteredVehicle = "";

    final querySnapshot =
        await FirebaseFirestore.instance.collection('vehicles').get();
    for (var doc in querySnapshot.docs) {
      // Search for document id if user was registered on other vehicle
      List<dynamic> recUserEmail = doc.get('listener');

      for (var email in recUserEmail) {
        if (email == widget.userEmail) {
          userRegistered = true;
          userRegisteredVehicle = doc.id;
          break;
        }
      }

      if (userRegistered) {
        break;
      }
    }

    if (userRegistered) {
      // remove user from other vehicle list
      await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(userRegisteredVehicle)
          .update({
            'listener': FieldValue.arrayRemove([widget.userEmail])
          }) // <-- Updated data
          .then((_) => print('Removed user from other vehicle listener list'))
          .catchError((error) => print('Update failed: $error'));

      // remove vehicle if no listener remaining after removal of user
      final docRef = await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(userRegisteredVehicle);

      DocumentSnapshot doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      print(
          "NUMPLATE => $userRegisteredVehicle Listener => ${data["listener"]}");

      if (data["listener"].isEmpty) {
        await docRef.delete().then(
              (doc) => print("Document deleted"),
              onError: (e) => print("Error updating document $e"),
            );
        ;
      }
    }
  }

  void clearPersonalVecAlerts() {
    // Meant for user to acknowledge alerts received and remove them after.
    Widget noButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        var collection = FirebaseFirestore.instance.collection('vehicles');
        collection.doc(registeredNumPlate).update({'reporter': []}).then((_) {
          Navigator.pop(context);
        }).catchError((error) => print(
            'Cleared alerts received from existing vehicle failed: $error'));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Clear Alerts?"),
      content: const Text(
          "Are you sure you would like to clear the alerts received on this registered vehicle?"),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> getUserRegisteredVehicle() async {
    //To get the number plate of the user's registered vehicle
    bool userRegistered = false;

    await FirebaseFirestore.instance.collection('vehicles').get().then((query) {
      for (var doc in query.docs) {
        // Getting data directly
        List<dynamic> recUserEmail = doc.get('listener');

        for (var email in recUserEmail) {
          if (email == widget.userEmail) {
            userRegistered = true;

            break;
          }
        }

        if (userRegistered) {
          personalVehicleNumPlateControl.text = doc.id;
          registeredNumPlate = doc.id;
          break;
        }
      }
    });
  }

  void listenToRegisteredVecAlert() async {
    // Constantly listen to changes in data to the user's registered vehicle
    // Mainly to receive alerts from other user(s)
    if (registeredNumPlate != "") {
      final docRef = await FirebaseFirestore.instance
          .collection("vehicles")
          .doc(registeredNumPlate);
      docRef.snapshots().listen(
        (event) {
          final data = event.data() as Map<String, dynamic>;
          if (data != null) {
            widget.updatePersonalVecAlertReceived(data["reporter"].length);
          }
        },
        onError: (error) => print("Listen failed: $error"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserRegisteredVehicle().then((value) {
      listenToRegisteredVecAlert();
      widget.updatePersonalVecNumPlate(registeredNumPlate);
    });
    ;

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

                    labelText: 'Personal Vehicle',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  registerVehicle();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  primary: Colors.cyan, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
                child: const Icon(Icons.app_registration_rounded,
                    color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  clearPersonalVecAlerts();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  primary: Colors.cyan, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
                child: const Icon(Icons.clear, color: Colors.white),
              ),
            ]));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    personalVehicleNumPlateControl.dispose();
    super.dispose();
  }
}
