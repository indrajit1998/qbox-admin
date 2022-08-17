import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qbox_admin/screens/auth/sign_in.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _logout(BuildContext context)async{
      Navigator.of(context).pushReplacementNamed(SignIn.routeName);
      await FirebaseAuth.instance.signOut();

    }
    return Scaffold(
        body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[

            ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('Back')),
            SizedBox(height: 22),

            Container(
            child: ElevatedButton(
              onPressed: ()=>_logout(context),
              child: Text('Log Out'),
            ),
          ),]
        ),

    ));
  }
}
