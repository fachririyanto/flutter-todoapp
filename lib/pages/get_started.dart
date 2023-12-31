import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import '../widgets/button.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // title
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              child: const Text(
                'Todo App',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),

            // description
            Container(
              margin: const EdgeInsets.only(bottom: 48),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'A simple todo app in your pocket',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.1,
                ),
              ),
            ),

            // image
            FittedBox(
              fit: BoxFit.fill,
              child: SvgPicture.asset(
                'lib/assets/draw.svg',
                fit: BoxFit.fill,
              ),
            ),

            // description
            Container(
              margin: const EdgeInsets.only(top: 32, bottom: 24),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // text
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: const Text(
                      'Before you start, setup your account.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                  ),

                  // button
                  Button(
                    text: 'Sign Up',
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    width: double.infinity,
                    height: 48,
                    onPressed: () {
                      Navigator.pushNamed(context, '/auth/signin');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
