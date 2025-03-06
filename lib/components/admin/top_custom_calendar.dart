import 'package:flutter/material.dart';
import 'package:tekko/components/admin/admin_calendar.dart';
import 'package:tekko/styles/app_colors.dart';

class TopCustomCalendar extends StatefulWidget {
  const TopCustomCalendar({super.key});

  @override
  State<TopCustomCalendar> createState() => _TopCustomCalendarState();
}

class _TopCustomCalendarState extends State<TopCustomCalendar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Gesto Actividades",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.softCreamDark),
                      )
                    ],
                  )
                ],
              )),
          const Positioned(top: 140, left: 0, right: 0, child: AdminCalendar())
        ],
      ),
    );
  }
}
