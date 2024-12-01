// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/screen/accountInfo.dart';
import 'package:nexplore/screen/loginScreeen.dart';
import 'package:nexplore/utils/extension/contextExtension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexplore/widgets/customShowDailog.dart';

class FirebaseServices {
// 1- Create A new Account
  static Future<void> createAccount({
    required String username,
    required String email,
    required String password,
    required BuildContext context,
    required bool isLoading,
    required String groupValue,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = credential.user!.email!; // Use email as UID
      await addUserToFirestore(
          uid: uid, email: email, groupValue: groupValue, username: username);
      context.showSnack(message: 'Registration Done...');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isLoading = false;
        context.showSnack(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        isLoading = false;
        context.showSnack(
            message: 'The account already exists for this email.');
      }
    } catch (e) {
      isLoading = false;
      context.showSnack(message: 'There was an error');
    }
  }

// 2- Add Data in firestore
  static Future<void> addUserToFirestore({
    required String uid,
    required String username,
    required String email,
    required String groupValue,
  }) async {
    // Add user data to Firestore using the email as the document ID (UID)
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'username': username,
      'gender': groupValue,
    });
    await FirebaseAuth.instance.signOut();
  }

  // 3- Login User
  static Future<void> loginUsers({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, AccountInformation.id,
          arguments: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        context.showSnack(message: 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        context.showSnack(message: 'Wrong password provided for that user.');
      }
    }
  }

  //4- Delete Account
  Future<void> _deleteAccount({required BuildContext context}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Show confirmation dialog
        bool confirm = await showDialog(
            context: context,
            builder: (context) => CustomShowDailog(context: context));

        if (confirm == true) {
          // Delete user from Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.email) // Use email as document ID
              .delete();

          // Delete user from Firebase Authentication
          await currentUser.delete();

          // Navigate back to login page
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LoginScreeen.id, (route) => false);
        }
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      // Handle errors here

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to delete account. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
