import 'package:cloud_data/pages/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../login_page/login_page.dart';

class Signup extends HookConsumerWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _fullName = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _confirmPassword = TextEditingController();
    final isPasswordHidden = useState<bool>(true);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _fullName,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        hintText: "Enter Full Name",
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _email,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: "mail@website.com",
                        labelText: "E-Mail",
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "E-Mail cannot be empty";
                        }
                        if (!RegExp(
                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-zA-Z0-9+_.-]+.[a-z]")
                            .hasMatch(value)) {
                          return "Please enter a valid E-Mail";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _password,
                      obsecureText: isPasswordHidden,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Enter password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            isPasswordHidden.value != isPasswordHidden.value;
                          },
                          icon: isPasswordHidden.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length < 8) {
                          return "Password must be atleast 8 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _confirmPassword,
                      obsecureText: isPasswordHidden,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            isPasswordHidden.value != isPasswordHidden.value;
                          },
                          icon: isPasswordHidden.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        hintText: "Confirm your password",
                        labelText: "Confirm password",
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (value != _password.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _fullName.text.trim();
                      _email.text.trim();
                      _password.text.trim();
                      _confirmPassword.text.trim();
                      if (_formKey.currentState!.validate()) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _email.text, password: _password.text)
                            .then(
                              (value) => Fluttertoast.showToast(
                                msg: "Welcome!",
                              ).then(
                                (value) =>
                                    Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const Dashboard(),
                                  ),
                                  (route) => false,
                                ),
                              ),
                            )
                            .onError(
                              (error, stackTrace) => Fluttertoast.showToast(
                                msg: error.toString(),
                              ),
                            );
                      }
                    },
                    child: const Text("Sign up"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: const Text("Log In"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
