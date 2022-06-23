import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:parker/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailInputControl = TextEditingController();
  bool dispTac = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  void loginVerification() {
    print("Verify hereeee ${emailInputControl.text}");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MyHomePage(title: "The number here")),
    );
  }

  void signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "App Name",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextFormField(
                    maxLength: 30,
                    controller: emailInputControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.clear),
                      ),
                      filled: true,
                      alignLabelWithHint: true,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      //[focusedBorder], displayed when [TextField, InputDecorator.isFocused] is true
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),

                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextFormField(
                    maxLength: 30,
                    obscureText: true,
                    controller: null,
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

                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      loginVerification();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Center(
                    child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    signUp();
                  },
                  child: const Text('Don\'t have an account? Sign up'),
                ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
