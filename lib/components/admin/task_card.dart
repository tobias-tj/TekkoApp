import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final int xp;
  final String startTime;
  final String endTime;
  final bool completed;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.xp,
    required this.startTime,
    required this.endTime,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.chocolateCream,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.chocolateNewDark.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "+$xp XP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.chocolateNewDark,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            completed
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: completed
                                ? AppColors.chocolateNewDark
                                : AppColors.chocolateDark,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: Colors.black54),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${_extractDate(startTime)} hasta ${_extractDate(endTime)}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 14, color: Colors.black54),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${_extractTime(startTime)} hasta ${_extractTime(endTime)}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  String _extractDate(String dateTime) {
    try {
      final parts = dateTime.split(',');
      return parts[0].trim();
    } catch (_) {
      return dateTime;
    }
  }

  String _extractTime(String dateTime) {
    try {
      final parts = dateTime.split(',');
      return parts[1]
          .trim()
          .replaceAll('a.', 'AM')
          .replaceAll('p.', 'PM')
          .split('m.')[0];
    } catch (_) {
      return dateTime;
    }
  }
}
