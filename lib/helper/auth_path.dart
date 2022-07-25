import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qbox_admin/screens/auth/sign_in.dart';
import 'package:qbox_admin/screens/home_page.dart';

class AuthPath extends StatelessWidget {
  static String routeName = "authPath";
  const AuthPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const SignIn();
          }
        },
      ),
    );
  }
}
