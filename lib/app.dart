import 'package:flutter/material.dart';
import 'package:tekko/screens/home_screen.dart';
import 'package:tekko/styles/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tekko',
      color: AppColors.softCreamDark,
      theme: ThemeData(
          primarySwatch: Colors.orange, primaryColor: AppColors.softCreamDark),
      home: const HomePage(),
    );
  }
}
