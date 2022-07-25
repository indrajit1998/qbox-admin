import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/screens/auth/sign_up.dart';
import 'package:qbox_admin/screens/home_page.dart';
import 'package:qbox_admin/utilities/dimensions.dart';

class SignIn extends StatefulWidget {
  static String routeName = 'signIn';
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  bool _signInFetching = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorMessage;
  double? padding;
  double? titleSize = 60;
  double? smallTextSize = 15;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((MediaQuery.of(context).size.width) <= 600) {
      padding = MediaQuery.of(context).size.width * (150 / 1563);
      titleSize = 60;
      smallTextSize = MediaQuery.of(context).size.width * (32 / 1563);
    } else if (MediaQuery.of(context).size.width <= 1000) {
      padding = MediaQuery.of(context).size.width * (300 / 1563);
      titleSize = 60;
      smallTextSize = MediaQuery.of(context).size.width * (32 / 1563);
    } else {
      padding = MediaQuery.of(context).size.width * (450 / 1563);
      titleSize = MediaQuery.of(context).size.width * (78 / 1563);
      smallTextSize = 15;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
              horizontal: padding!,
              vertical: MediaQuery.of(context).size.height * (5 / 792)),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.pexels.com/photos/5412500/pexels-photo-5412500.jpeg?auto=compress&cs=tinysrgb&w=600'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * (75 / 792),
              ),
              padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * (30 / 1563)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200.withOpacity(0.5),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' Q-Box ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleSize,
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (120 / 792),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width *
                                    (10 / 1563)),
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                _emailController.text = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please Enter Your Email");
                                }
                                // reg expression for email validation
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please Enter a valid email");
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadius12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadius12),
                                ),
                                hintText: "Email",
                                fillColor: Colors.grey[100],
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width *
                                    (10 / 1563)),
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              onSaved: (value) {
                                _passwordController.text = value!;
                              },
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return ("Password is required for login");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid Password(Min. 6 Character)");
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadius12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadius12),
                                ),
                                hintText: "password",
                                fillColor: Colors.grey[100],
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * (40 / 792),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _signInFetching = true;
                              });
                              signIn(_emailController.text,
                                  _passwordController.text);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      (10 / 1563)),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadius5),
                                ),
                                child: Center(
                                  child: _signInFetching
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Sign In",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (20 / 792),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Divider(
                            color: Theme.of(context).primaryColor,
                          )),
                          const Text("Sign up with Us"),
                          Expanded(
                              child: Divider(
                            color: Theme.of(context).primaryColor,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (10 / 792),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Not Yet Register?",
                              style: TextStyle(fontSize: smallTextSize),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(
                                  context, SignUp.routeName);
                            },
                            child: Text(
                              'Create Account',
                              style: TextStyle(fontSize: smallTextSize! + 3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((uid) => {
                  setState(() {
                    _signInFetching = false;
                  }),
                  Fluttertoast.showToast(msg: 'Sign In Successful'),
                  Navigator.popAndPushNamed(context, HomePage.routeName),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
    setState(() {
      _signInFetching = false;
    });
  }
}
