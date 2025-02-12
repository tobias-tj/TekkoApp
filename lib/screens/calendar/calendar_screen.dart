import 'package:flutter/material.dart';
import 'package:tekko/components/agend_list.dart';
import 'package:tekko/components/top_custom_calendar.dart';
import 'package:tekko/styles/app_colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
              TopCustomCalendar(),
              const SizedBox(height: 2),
              const AgendList()
            ],
          )
        ]));
  }
}
