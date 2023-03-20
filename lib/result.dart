import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String technology = "empty";
  String email = "empty";
  String password = "empty";
  String department = "empty";
  bool flutter = false;
  bool java = false;
  bool kotlin = false;
  
  void getData() {
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          email = element.data()["email"];
          password = element.data()["password"];
        });
      });
    });
    FirebaseFirestore.instance.collection("info").get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
        setState(() {
          flutter = element.data()["flutter"];
          java = element.data()["java"];
          kotlin = element.data()["kotlin"];
          department = element.data()["department"];
        });
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Email"),
            subtitle: Text(email),
          ),
          ListTile(
            title: const Text("Password"),
            subtitle: Text(password),
          ),
          ListTile(
            title: const Text("Department"),
            subtitle: Text(department),
          ),
          ListTile(
            title: const Text("Technology"),
            subtitle: Text(flutter
                ? "Flutter"
                : java
                    ? "Java"
                    : kotlin
                        ? "Kotlin"
                        : "empty"),
          ),
        ],
      ),
    );
  }
}
