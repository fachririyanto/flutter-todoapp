import 'package:flutter/material.dart';
import '../../utils/auth.dart';
import '../../utils/colors.dart';
import '../../models/user.dart';
import '../../widgets/textbox.dart';
import '../../widgets/button.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String name = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserModel().getCurrentUser().then((user) {
        if (user == null) {
          Navigator.of(context).pushNamed('/auth/signup');
        } else {
          setState(() {
            name = user.name ?? '';
          });
        }
      });
    });
  }

  // signin
  void signin() async {
    UserModel().signin(name, password).then((user) {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid password'),
          ),
        );

        return;
      }

      // clear form
      passwordController.clear();

      // save user name
      UserAuth().setUser(name);

      // navigate to todo page
      Navigator.pushNamed(context, '/todo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // header
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // description
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'Welcome back, $name',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // form
          Form(
            key: _formKey,
            child: Column(children: [
              // textbox - password
              Container(
                margin: const EdgeInsets.only(bottom: 16),
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
                      signin();
                    }
                  },
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
