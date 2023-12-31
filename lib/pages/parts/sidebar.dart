import 'package:flutter/material.dart';
import '../../utils/auth.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.task,
                color: Colors.black,
              ),
              title: const Text(
                'Todo List',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/todo');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: const Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/update-profile');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                UserAuth.logout().then((_) {
                  Navigator.of(context).pushNamed('/auth/signin');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
