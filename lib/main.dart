import 'package:flutter/material.dart';
import './pages/auth.dart';
import './pages/auth/signin.dart';
import './pages/auth/signup.dart';
import './pages/get_started.dart';
import './pages/todo.dart';
import './pages/update_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const AuthPage(),
        '/auth/signin': (context) => const SigninPage(),
        '/auth/signup': (context) => const SignupPage(),
        '/get-started': (context) => const GetStartedPage(),
        '/todo': (context) => const TodoPage(),
        '/update-profile': (context) => const UpdateProfilePage(),
      },
    );
  }
}
