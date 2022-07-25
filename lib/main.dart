import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qbox_admin/helper/auth_path.dart';
import 'package:qbox_admin/screens/auth/sign_in.dart';
import 'package:qbox_admin/screens/auth/sign_up.dart';
import 'package:qbox_admin/screens/home_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(
          Theme.of(context).textTheme,
        ),
        dividerColor: Colors.transparent,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        }),
        primaryColor: const Color(0xFFFFC600),
        primarySwatch: Colors.amber,
      ),
      routes: {
        SignIn.routeName: (_) => const SignIn(),
        SignUp.routeName: (_) => const SignUp(),
        AuthPath.routeName: (_) => const AuthPath(),
        HomePage.routeName: (_) => const HomePage(),
      },
      home: const AuthPath(),
    );
  }
}
