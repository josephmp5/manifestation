import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manifestation/pages/manifest.dart';
import 'package:page_transition/page_transition.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signInWithAnonymous(BuildContext context) async {
    try {
      final userCredential = await auth.signInAnonymously();
      final user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'tokens': 35,
          'subscription': false,
        });

        // ignore: use_build_context_synchronously
        await Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const Manifest()));
      } else {
        const Center(
          child: CircularProgressIndicator(),
        );
      }
    } on FirebaseAuthException catch (e) {
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  // String _verificationId = "";

  // Future<void> startPhoneVerification(String phoneNumber, String name) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // Automatically verify and link
  //       await linkAnonymousAccountWithPhone(credential, name);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       print("Phone verification failed: ${e.message}");
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       _verificationId = verificationId;
  //       print("SMS code sent. Verification ID: $_verificationId");
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       _verificationId = verificationId;
  //     },
  //   );
  // }

  // Future<void> linkAnonymousAccountWithPhone(
  //     dynamic credentialOrSmsCode, String name) async {
  //   try {
  //     PhoneAuthCredential credential;

  //     // Check if the input is a PhoneAuthCredential or smsCode (String)
  //     if (credentialOrSmsCode is PhoneAuthCredential) {
  //       credential = credentialOrSmsCode;
  //     } else if (credentialOrSmsCode is String) {
  //       credential = PhoneAuthProvider.credential(
  //         verificationId: _verificationId,
  //         smsCode: credentialOrSmsCode,
  //       );
  //     } else {
  //       throw Exception("Invalid input for linking account");
  //     }

  //     // Link the credential to the existing anonymous account
  //     await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);

  //     // Save the name and premium status to Firestore or your database
  //     await saveUserDetails(name);

  //     print("Account upgraded successfully!");
  //   } catch (e) {
  //     print("Error linking account: $e");
  //   }
  // }

  // Future<void> saveUserDetails(String name) async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;

  //   await FirebaseFirestore.instance.collection('users').doc(uid).set({
  //     'name': name,
  //     'premium': true,
  //     'updatedAt': FieldValue.serverTimestamp(),
  //   }, SetOptions(merge: true));

  //   print("User details saved to Firestore.");
  // }
}
