import 'package:flutter/material.dart';
import 'package:tekko/components/admin/top_custom_calendar.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.softCream,
          ),
          Column(
            children: [
              TopCustomCalendar(),
              const SizedBox(height: 2),
            ],
          )
        ],
      ),
    );
  }
}
