import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class TopTitleGeneric extends StatelessWidget {
  const TopTitleGeneric({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.2,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: size.height * 0.2,
                color: AppColors.chocolateNewDark,
              )),
          Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Favoritos",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.softCreamDark),
                        )
                      ],
                    )
                  ])),
        ],
      ),
    );
  }
}
