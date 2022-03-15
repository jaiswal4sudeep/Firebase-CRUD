import 'package:flutter/material.dart';

class UpdateData extends StatelessWidget {
  const UpdateData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _fullName = TextEditingController();
    TextEditingController _email = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User Data'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Form(
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
                  onPressed: () {},
                  child: const Text("Update Profile"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
