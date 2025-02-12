import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class CardCalendar extends StatefulWidget {
  const CardCalendar({super.key});

  @override
  State<CardCalendar> createState() => _CardCalendarState();
}

class _CardCalendarState extends State<CardCalendar> {
  late List<Map<String, dynamic>> weekDates;

  @override
  void initState() {
    super.initState();
    _loadMockDates();
  }

  void _loadMockDates() {
    weekDates = [
      {"day": 7, "weekday": "Domingo", "isToday": false},
      {"day": 8, "weekday": "Lunes", "isToday": true},
      {"day": 9, "weekday": "Martes", "isToday": false},
      {"day": 10, "weekday": "Miércoles", "isToday": false},
      {"day": 11, "weekday": "Jueves", "isToday": false},
      {"day": 12, "weekday": "Viernes", "isToday": false},
      {"day": 13, "weekday": "Sábado", "isToday": false},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.softCreamDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Esta",
                  style: TextStyle(
                    fontSize: 23,
                    color: AppColors.chocolateNewDark,
                  ),
                ),
                const Text(
                  " semana",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppColors.chocolateNewDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Lista de Fechas con Scroll Horizontal
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: weekDates.map((date) {
                    bool isToday = date['isToday'];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isToday
                                  ? AppColors.chocolateNewDark
                                  : AppColors.softCream,
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                            child: Text(
                              "${date['day']}",
                              style: TextStyle(
                                color: isToday
                                    ? Colors.white
                                    : AppColors.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            date['weekday'],
                            style: TextStyle(
                              color: isToday
                                  ? AppColors.chocolateNewDark
                                  : Colors.white,
                              fontWeight:
                                  isToday ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ))
          ],
        ),
      ),
    );
  }
}
