import 'package:flutter/material.dart';
import '../utils/auth.dart';
import '../models/user.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserModel().isUserExists().then((isUserExists) {
        if (isUserExists) {
          UserAuth.isLoggedIn().then((isLoggedIn) {
            if (isLoggedIn) {
              Navigator.of(context).pushNamed('/todo');
            } else {
              Navigator.of(context).pushNamed('/auth/signin');
            }
          });
        } else {
          Navigator.of(context).pushNamed('/get-started');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
