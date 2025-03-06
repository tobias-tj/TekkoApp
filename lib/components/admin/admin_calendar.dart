import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminCalendar extends StatefulWidget {
  const AdminCalendar({super.key});

  @override
  State<AdminCalendar> createState() => _AdminCalendarState();
}

class _AdminCalendarState extends State<AdminCalendar> {
  late List<Map<String, dynamic>> weekDates;
  DateTime _selectedDate = DateTime.now();
  int _selectedMonthIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadMockDates();
  }

  void _loadMockDates() {
    // Lista de nombres de los meses
    final List<String> months = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre"
    ];

    // Lista para almacenar los datos de los meses
    weekDates = [];

    // Recorremos cada mes y le asignamos la primera semana
    for (int i = 0; i < months.length; i++) {
      weekDates.add({
        "month": months[i], // Nombre del mes
        "week": _getFirstWeekOfMonth(DateTime(_selectedDate.year, i + 1))
      });
    }
  }

  List<Map<String, dynamic>> _getFirstWeekOfMonth(DateTime month) {
    List<Map<String, dynamic>> week = [];
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);

    int offset = firstDayOfMonth.weekday - 1; // Lunes = 1, Domingo = 7
    DateTime currentDay = firstDayOfMonth.subtract(Duration(days: offset));

    // Generar los 7 días de la primera semana
    for (int i = 0; i < 7; i++) {
      if (currentDay.month == month.month) {
        week.add({
          "day": currentDay.day,
          "weekday": _getWeekdayName(currentDay.weekday),
          "isToday": currentDay.day == DateTime.now().day &&
              currentDay.month == DateTime.now().month &&
              currentDay.year == DateTime.now().year,
        });
      } else {
        week.add({
          "day": null,
          "weekday": "",
          "isToday": false,
        });
      }
      currentDay = currentDay.add(const Duration(days: 1));
    }

    return week;
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return "Lunes";
      case 2:
        return "Martes";
      case 3:
        return "Miércoles";
      case 4:
        return "Jueves";
      case 5:
        return "Viernes";
      case 6:
        return "Sábado";
      case 7:
        return "Domingo";
      default:
        return "";
    }
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
            const SizedBox(height: 6),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: weekDates.asMap().entries.map((entry) {
                  int index = entry.key;
                  var month = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedMonthIndex = index; // Cambiar mes activo
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedMonthIndex == index
                            ? Colors.orange // Resalta el mes seleccionado
                            : AppColors.chocolateNewDark,
                        padding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: Text(
                        month['month'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Column(
                children: [
                  // Días de la semana (solo del mes seleccionado)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: weekDates[_selectedMonthIndex]['week']
                          .map<Widget>((day) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 48,
                                height: 65,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: day['isToday']
                                        ? Colors.orange
                                        : const Color.fromARGB(61, 84, 41, 10),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: Text(
                                    day['day']?.toString() ?? "",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Center(
                                child: Text(
                                  day['weekday'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
