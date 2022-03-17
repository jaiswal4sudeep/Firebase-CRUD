// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateData extends StatelessWidget {
  final previousName;
  final previousEmail;
  final currentIndex;
  const UpdateData(
      {Key? key, this.previousName, this.previousEmail, this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _fullName = TextEditingController();
    TextEditingController _email = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    _fullName.text = previousName;
    _email.text = previousEmail;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                      textInputAction: TextInputAction.done,
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
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(currentIndex)
                            .update(
                              {
                                'name': _fullName.text,
                                'email': _email.text,
                              },
                            )
                            .then(
                              (value) =>
                                  Fluttertoast.showToast(msg: "Profile Updated")
                                      .then(
                                (value) => Navigator.of(context).pop(),
                              ),
                            )
                            .onError(
                              (error, stackTrace) => Fluttertoast.showToast(
                                msg: error.toString(),
                              ),
                            );
                      }
                    },
                    child: const Text("Update Profile"),
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
