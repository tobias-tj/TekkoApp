import 'package:flutter/material.dart';
import 'package:tekko/components/admin/task_card.dart';
import 'package:tekko/components/admin/top_custom_calendar.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final List<Map<String, dynamic>> mockTasks = [
    {
      "title": "Limpiar Cuarto",
      "description":
          "Phasellus vel purus ultricies, posuere diam ac, commodo magna.",
      "xp": 10,
      "startTime": "8:07",
      "endTime": "8:23",
      "completed": true,
    },
    {
      "title": "Sacar Basura",
      "description":
          "Phasellus vel purus ultricies, posuere diam ac, commodo magna.",
      "xp": 25,
      "startTime": "9:10",
      "endTime": "9:15",
      "completed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.chocolateNewDark,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              TopCustomCalendar(),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tiempo"),
                    const Text("Detalle Actividades"),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.chocolateCream,
                        foregroundColor: AppColors.chocolateNewDark,
                      ),
                      child: Row(
                        children: const [
                          Text("All"),
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.chocolateNewDark,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: mockTasks.length,
                  itemBuilder: (context, index) {
                    final task = mockTasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              "${task['startTime']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TaskCard(
                              title: task['title'],
                              description: task['description'],
                              xp: task['xp'],
                              startTime: task['startTime'],
                              endTime: task['endTime'],
                              completed: task['completed'],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
