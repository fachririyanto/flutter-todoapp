import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../collections/user.dart';
import '../../models/user.dart';
import '../../widgets/textbox.dart';
import '../../widgets/button.dart';
import '../utils/auth.dart';
import './parts/sidebar.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
      ),
      drawer: const Sidebar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FutureBuilder<User?>(
              future: UserModel().getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final user = snapshot.data;

                if (user == null) {
                  return const SizedBox(
                    child: Text(
                      'No todos found!',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  );
                }

                nameController.text = user.name!;
                passwordController.text = user.password!;

                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Textbox(
                          controller: nameController,
                          hintText: 'Your Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Textbox(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        child: Button(
                          width: double.infinity,
                          height: 48,
                          text: 'Update Data',
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // update data user
                              UserModel()
                                  .updateUser(user.id, nameController.text,
                                      passwordController.text)
                                  .then((value) {
                                // update auth user
                                UserAuth().setUser(nameController.text);

                                // show message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Profile updated'),
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
