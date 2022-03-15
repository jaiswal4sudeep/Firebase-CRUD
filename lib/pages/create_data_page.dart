// import 'package:cloud_data/pages/Image%20Pick/profilepicture.dart';

import 'package:cloud_data/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateData extends StatelessWidget {
  const CreateData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _fullName = TextEditingController();
    TextEditingController _email = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
        leading: IconButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UserModel userModel = UserModel();
                      userModel.name = _fullName.text;
                      userModel.email = _email.text;
                      userModel.avatar = _fullName.text.substring(0, 1);
                      await firebaseFirestore
                          .collection("users")
                          .add(userModel.toMap())
                          .then(
                            (value) =>
                                Fluttertoast.showToast(msg: "Profile Created!")
                                    .then(
                                      (value) => Navigator.of(context).pop(),
                                    )
                                    .onError(
                                      (error, stackTrace) =>
                                          Fluttertoast.showToast(
                                        msg: error.toString(),
                                      ),
                                    ),
                          );
                    }
                  },
                  child: const Text("Create Profile"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
