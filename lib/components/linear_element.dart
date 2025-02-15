import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class LinearElement extends StatelessWidget {
  const LinearElement({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 1.0,
        width: size.width,
        color: AppColors.chocolateNewDark,
      ),
    );
  }
}
