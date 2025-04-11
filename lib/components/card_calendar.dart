import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class CardCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CardCalendar({super.key, required this.onDateSelected});

  @override
  State<CardCalendar> createState() => _CardCalendarState();
}

class _CardCalendarState extends State<CardCalendar> {
  late List<Map<String, dynamic>> weekDates;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _loadWeekDates();
  }

  void _loadWeekDates() {
    DateTime today = DateTime.now();

    // Obtener el domingo de esta semana
    int currentWeekday = today.weekday; // lunes = 1, domingo = 7
    DateTime startOfWeek = today.subtract(Duration(days: currentWeekday % 7));

    weekDates = List.generate(7, (index) {
      DateTime date = startOfWeek.add(Duration(days: index));
      return {
        "date": date,
        "day": date.day,
        "weekday": _getWeekdayName(date.weekday),
        "isToday": _isSameDate(date, today),
      };
    });
  }

  String _getWeekdayName(int weekday) {
    const weekNames = [
      'Domingo',
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado'
    ];
    return weekNames[weekday % 7]; // para que domingo (7) sea index 0
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
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
                    DateTime currentDate = date['date'];
                    bool isSelected = selectedDate != null &&
                        _isSameDate(currentDate, selectedDate!);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedDate = currentDate;
                              });
                              widget.onDateSelected(currentDate);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? AppColors.chocolateNewDark
                                  : (isToday
                                      ? AppColors.softCream
                                      : AppColors.softCream),
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                                side: isToday
                                    ? const BorderSide(
                                        color: AppColors.chocolateNewDark,
                                        width: 2,
                                      )
                                    : BorderSide.none,
                              ),
                            ),
                            child: Text(
                              "${date['day']}",
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : (isToday
                                        ? AppColors.chocolateNewDark
                                        : AppColors.textColor),
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
