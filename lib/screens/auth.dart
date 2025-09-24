import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:just_chat/constants/common.dart';
import 'package:just_chat/utils/firebase.dart';
import 'package:just_chat/widgets/profile_avatar_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum SubmitState { idle, submitting, success, error }

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  String email = '';
  String password = '';
  String username = '';
  File? profileImage;
  final formKey = GlobalKey<FormState>();
  SubmitState submitState = SubmitState.idle;

  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

    setState(() {
      submitState = SubmitState.submitting;
    });
    if (isLogin) {
      login(email, password);
    } else {
      registerUser(email, password, username, profileImage);
    }
  }

  void registerUser(
    String email,
    String password,
    String username,
    File? profileImage,
  ) async {
    try {
      final credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final storageRef = FirebaseStorage.instance.ref();
      final fileRef = storageRef
          .child('user_images')
          .child('avatar')
          .child('${credentials.user!.uid}.jpg');
      String? fileUrl;
      if (profileImage != null) {
        await fileRef.putFile(profileImage);
        fileUrl = await fileRef.getDownloadURL();
      }

      debugPrint(
        "User registered: ${credentials.user?.email} with image:$fileUrl",
      );
      final firestore = FirebaseFirestore.instanceFor(
        app: Firebase.app(),
        databaseId: 'just-chat-db',
      );
      
      await firestore.collection('users').doc(credentials.user!.uid).set({
        'username': username,
        'email': email,
        'imageUrl': fileUrl,
      });

      setState(() {
        submitState = SubmitState.success;
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Authentication failed with error"),
        ),
      );

      setState(() {
        submitState = SubmitState.error;
      });
    }
  }

  void login(String user, String password) async {
    try {
      final credentials = await firebaseAuth.signInWithEmailAndPassword(
        email: user,
        password: password,
      );
      debugPrint("User signed in: ${credentials.user?.email}");
      setState(() {
        submitState = SubmitState.success;
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Authentication failed with error"),
        ),
      );
      setState(() {
        submitState = SubmitState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24),
                alignment: Alignment.center,
                width: 240,
                height: 240,
                child: Image.asset(Assets.chatImage, fit: BoxFit.cover),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          if (!isLogin) ...[
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  foregroundImage: profileImage != null
                                      ? FileImage(profileImage!)
                                      : null,
                                ),
                                SizedBox(height: 8),
                                ProfileAvatarPicker(
                                  onImagePicked: (image) {
                                    setState(() {
                                      profileImage = image;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Username:',
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.length <= 4) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                username = value!;
                              },
                            ),
                            SizedBox(height: 12),
                          ],
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email Address: ",
                              hintText: "Enter your email address here",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email = value!;
                            },
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password: ",
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return 'Please enter a valid password (min. 6 characters)';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: submitState == SubmitState.submitting
                    ? null
                    : submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  foregroundColor: submitState == SubmitState.submitting
                      ? Theme.of(context).colorScheme.surfaceTint.withAlpha(100)
                      : null,
                ),
                child: submitState == SubmitState.submitting
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Text(
                        isLogin == true ? "Login" : "Signup",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
              ),
              SizedBox(height: 4),
              TextButton(
                onPressed: () => setState(() {
                  isLogin = !isLogin;
                }),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Colors.white),
                ),
                child: Text(
                  isLogin == true
                      ? 'Create new account'
                      : 'Already have an account',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
