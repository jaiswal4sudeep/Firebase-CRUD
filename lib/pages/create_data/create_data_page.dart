import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateData extends HookConsumerWidget {
  const CreateData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _fullName = TextEditingController();
    TextEditingController _email = TextEditingController();
    final _avatar = useState<String>("*");
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 80,
                child: Text(
                  _avatar.value,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
                        _avatar.value = _fullName.text.substring(0, 1);
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
                       _fullName.text.trim();
                      _email.text.trim();
                      if (_formKey.currentState!.validate()) {
                        await firebaseFirestore.collection("users").add(
                          {
                            'name': _fullName.text,
                            'email': _email.text,
                            'avatar': _avatar.value.toUpperCase(),
                          },
                        ).then(
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
      ),
    );
  }
}
