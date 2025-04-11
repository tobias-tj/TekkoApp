import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/components/agend_list.dart';
import 'package:tekko/components/top_custom_calendar.dart';
import 'package:tekko/styles/app_colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? selectedDate;

  void _handleDateChanged(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // fecha actual por defecto
  }

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
              TopCustomCalendar(onDateChanged: _handleDateChanged),
              const SizedBox(height: 2),
              AgendList(
                selectedDate: selectedDate,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     TextButton(
              //       onPressed: () {
              //         context.push('/winner');
              //       },
              //       child: const Text("Animación Ganador"),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         context.push('/levelUp');
              //       },
              //       child: const Text("Subir de Nivel"),
              //     ),
              //   ],
              // )
            ],
          ),
        ]));
  }
}
