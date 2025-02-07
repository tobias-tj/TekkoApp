import 'package:flutter/material.dart';
import 'package:tekko/components/top_custom_title.dart';
import 'package:tekko/styles/app_colors.dart';

class WordScreen extends StatefulWidget {
  final String textTitle;
  const WordScreen({super.key, required this.textTitle});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.softCream,
        body: Stack(children: [
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.softCream,
          ),
          Column(
            children: [
              TopCustomTitle(title: widget.textTitle),
            ],
          )
        ]));
  }
}
