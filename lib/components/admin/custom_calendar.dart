import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tekko/styles/app_colors.dart';

class CustomCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CustomCalendar({super.key, required this.onDateSelected});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _currentDate;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _selectedDate = DateTime.now();
    initializeDateFormatting('es'); // Inicializa formatos en español
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.softCream,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          _buildWeekDays(),
          const SizedBox(height: 4),
          _buildDaysGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, size: 24),
          color: AppColors.chocolateNewDark,
          onPressed: () => setState(() {
            _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
          }),
        ),
        Text(
          DateFormat('MMMM yyyy', 'es').format(_currentDate),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateNewDark,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, size: 24),
          color: AppColors.chocolateNewDark,
          onPressed: () => setState(() {
            _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
          }),
        ),
      ],
    );
  }

  Widget _buildWeekDays() {
    final weekDays = DateFormat.E('es').dateSymbols.SHORTWEEKDAYS;
    final orderedWeekDays = [...weekDays.sublist(1), weekDays[0]];

    return Row(
      children: orderedWeekDays
          .map((day) => Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolateNewDark,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDaysGrid() {
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final daysInMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
    final startingWeekday = firstDayOfMonth.weekday;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.5,
      ),
      itemCount: daysInMonth + startingWeekday - 1,
      itemBuilder: (context, index) {
        if (index < startingWeekday - 1) return const SizedBox.shrink();

        final day = index - startingWeekday + 2;
        final currentDay = DateTime(_currentDate.year, _currentDate.month, day);
        final isSelected = _selectedDate.year == currentDay.year &&
            _selectedDate.month == currentDay.month &&
            _selectedDate.day == currentDay.day;
        final isToday = currentDay.year == DateTime.now().year &&
            currentDay.month == DateTime.now().month &&
            currentDay.day == DateTime.now().day;

        return GestureDetector(
          onTap: () {
            setState(() => _selectedDate = currentDay);
            widget.onDateSelected(currentDay);
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color:
                  isSelected ? AppColors.chocolateNewDark : Colors.transparent,
              border: isToday && !isSelected
                  ? Border.all(color: AppColors.chocolateNewDark, width: 1.5)
                  : null,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : AppColors.chocolateNewDark,
                  fontWeight: isSelected || isToday
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
