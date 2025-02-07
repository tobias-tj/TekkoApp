import 'package:flutter/material.dart';
import 'package:tekko/screens/accounts/create_account_step.dart';
import 'package:tekko/styles/app_colors.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.softCream,
          ),
          const CustomBackground(),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'T E K K O',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: AppColors.softCreamDark,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/iconTitleDog.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CreateAccountStep()
        ],
      ),
    );
  }
}

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image.asset(
      'assets/images/bgAccount.png',
      width: size.width,
      height: size.height * 0.4,
      fit: BoxFit.cover,
    );
  }
}
