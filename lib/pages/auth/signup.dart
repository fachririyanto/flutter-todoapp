import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../collections/user.dart';
import '../../models/user.dart';
import '../../widgets/textbox.dart';
import '../../widgets/button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String name = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  // signup
  void signup() async {
    final user = User(name: name, password: password);

    UserModel().createUser(user).then((value) {
      // clear form
      nameController.clear();
      passwordController.clear();

      // navigate to login page
      Navigator.pushNamed(context, '/auth/signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // header
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // description
            Container(
              margin: const EdgeInsets.only(bottom: 48),
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Setup your account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // textbox - name
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Textbox(
                      controller: nameController,
                      hintText: 'Your Name',
                      onChanged: (value) => setState(() {
                        name = value!;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Your name is required';
                        }
                        return null;
                      },
                    ),
                  ),

                  // textbox - password
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Textbox(
                      controller: passwordController,
                      obscureText: true,
                      hintText: 'Password',
                      onChanged: (value) => setState(() {
                        password = value!;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            // button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Button(
                text: 'Sign In',
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
                width: double.infinity,
                height: 48,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signup();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
