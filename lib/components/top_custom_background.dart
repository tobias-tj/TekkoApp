import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class TopCustomBackground extends StatelessWidget {
  final String title;
  const TopCustomBackground({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Image.asset(
          'assets/images/topHome.png',
          width: size.width,
          height: size.height * 0.25,
          fit: BoxFit.cover,
        ),
        Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softCreamDark),
                )
              ],
            ))
      ],
    );
  }
}
