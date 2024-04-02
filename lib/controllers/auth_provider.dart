import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_task/service/auth_service.dart';

class AuthProviders extends ChangeNotifier {
  Future<UserCredential>? user;
  FirebaseAuthServices  service = FirebaseAuthServices();
  signInWithEmail(String email, String password, BuildContext context) {
    return service.signInWithEmailAndPassword(email, password, context);
  }

  signUpWithEmail(String email, String password, String name) {
    return service.signInWithEmailAndPassword(email, password, name);
  }


}
