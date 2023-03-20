import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_application/result.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool flutter = false;
  bool java = false;
  bool kotlin = false;

  var items = [
    'CE',
    'CSE',
    'IT',
  ];
  String selectedVal = "CE";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Select the technology"),
          const SizedBox(height: 10),
          CheckboxListTile(
            value: flutter,
            onChanged: (value) {
              setState(() {
                flutter = value!;
              });
            },
            title: const Text("Flutter"),
          ),
          CheckboxListTile(
            value: java,
            onChanged: (value) {
              setState(() {
                java = value!;
              });
            },
            title: const Text("Java"),
          ),
          CheckboxListTile(
            value: kotlin,
            onChanged: (value) {
              setState(() {
                kotlin = value!;
              });
            },
            title: const Text("Kotlin"),
          ),
          const SizedBox(height: 20),
          const Text("Select the department"),
          DropdownButton(
              value: selectedVal,
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? val) {
                setState(() {
                  selectedVal = val!;
                });
              })
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseFirestore.instance.collection("info").doc().set({
              "flutter": flutter,
              "java": java,
              "kotlin": kotlin,
              "department": selectedVal
            }).then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Result())));
          },
          label: const Text("Submit")),
    );
  }
}
