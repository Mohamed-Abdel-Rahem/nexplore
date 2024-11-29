// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/screen/accountInfo.dart';
import 'package:nexplore/screen/homePage.dart';
import 'package:nexplore/utils/extension/contextExtension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}
