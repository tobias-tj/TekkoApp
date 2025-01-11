import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Center(child: Text("Desde Calendar")),
    );
  }
}
