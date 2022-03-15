// ignore_for_file: avoid_print

import 'package:cloud_data/model/usermodel.dart';
import 'package:cloud_data/pages/create_data_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  UserModel userModel = UserModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (builder, dataFetched) {
            final data = dataFetched.data!.docs;
            if (dataFetched.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.isEmpty) {
              return const Center(
                child: Text("No Data"),
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: <Widget>[
                          SlidableAction(
                            onPressed: (a) {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const UpdateData(),
                              //   ),
                              // );
                              Fluttertoast.showToast(msg: "Data Updated");
                            },
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (a) {
                              daleteData('users', data[index].id);
                            },
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(data[index]["avatar"]),
                          ),
                          title: Text(data[index]["name"]),
                          subtitle: Text(data[index]["email"]),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateData(),
            ),
          );
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}

void daleteData(String users, String id) async {
  FirebaseFirestore.instance.collection(users).doc(id).delete().then(
        (value) => Fluttertoast.showToast(msg: "Data Deleted"),
      );
}
