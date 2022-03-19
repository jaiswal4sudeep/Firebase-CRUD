import 'package:cloud_data/pages/create_data/create_data_page.dart';
import 'package:cloud_data/pages/login_page/login_page.dart';
import 'package:cloud_data/pages/update_data/update_data_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then(
                      (value) => Fluttertoast.showToast(
                        msg: "Logged out!", // TODO: Fluttertoast Glitch Fix
                      ).then(
                        (value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (builder, dataFetched) {
            final gotData = dataFetched.data?.docs;
            if (dataFetched.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (gotData!.isEmpty) {
              return const Center(
                child: Text("No Data Available!"),
              );
            } else {
              return ListView.builder(
                itemCount: gotData.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: <Widget>[
                        SlidableAction(
                          onPressed: (a) {
                            String name = gotData[index]["name"];
                            String email = gotData[index]["email"];
                            String avatar = gotData[index]["avatar"];
                            String dataIndex = gotData[index].id;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdateData(
                                  previousName: name,
                                  previousEmail: email,
                                  currentIndex: dataIndex,
                                  previousAvatar: avatar,
                                ),
                              ),
                            );
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
                            daleteData('users', gotData[index].id);
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
                          child: Text(gotData[index]["avatar"] ?? ""),
                        ),
                        title: Text(gotData[index]["name"] ?? "NanN"),
                        subtitle: Text(gotData[index]["email"] ?? "NaN"),
                      ),
                    ),
                  );
                },
              );
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
        (value) => Fluttertoast.showToast(msg: "Profile Deleted"),
      );
}
