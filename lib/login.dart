import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_application/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = false;
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Image.asset('assets/user.png'),
              const SizedBox(height: 20),
              Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 10,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text("Nice to see you again...",
                  style: TextStyle(color: Colors.black.withOpacity(.4))),
              const SizedBox(height: 30),
              TextField(
                controller: emailContoller,
                decoration: InputDecoration(
                  hintText: "example@gmail.com",
                  label: const Text("Email"),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(.4)),
                  prefixIcon: const Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.4)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible
                          ? const Icon(Icons.remove_red_eye_outlined)
                          : const Icon(Icons.remove_red_eye)),
                  hintText: "********",
                  label: const Text("Password"),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(.4)),
                  prefixIcon: const Icon(Icons.key),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.4)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.black.withOpacity(.4)),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (emailContoller.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    auth
                        .signInWithEmailAndPassword(
                            email: emailContoller.text,
                            password: passwordController.text)
                        .then((value) {
                      FirebaseFirestore instance = FirebaseFirestore.instance;
                      instance.collection("users").doc().set({
                        "email": emailContoller.text,
                        "password": passwordController.text,
                      }).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                        print("User Added");
                      });
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(18)),
                  child: const Center(
                      child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              const SizedBox(height: 10),
              const Text("OR"),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.4),
                        blurRadius: 10.0,
                        spreadRadius: 3.0,
                        offset: const Offset(4.0, 7.0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 30, child: Image.asset('assets/google.png')),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Continue with Google",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.4),
                        blurRadius: 10.0,
                        spreadRadius: 3.0,
                        offset: const Offset(4.0, 7.0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                child: const Center(
                  child: Text(
                    "Sign in with phone number",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
