import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/components/admin/custom_calendar.dart';
import 'package:tekko/components/admin/task_card.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  DateTime? _selectedDate;

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
        onPressed: () => context.goNamed('createActivity'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height * 0.4 + 120,
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
                    Positioned(
                      top: 95,
                      left: 0,
                      right: 0,
                      child: CustomCalendar(
                        onDateSelected: (date) {
                          print('Fecha seleccionada desde padre: $date');
                          // Aquí puedes hacer lo que necesites con la fecha
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: const Text(
                        "Actividades",
                        style: TextStyle(color: AppColors.chocolateNewDark),
                      ),
                    ),
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
              if (_selectedDate != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Fecha seleccionada: ${_selectedDate!.toLocal()}",
                    style: TextStyle(
                      color: AppColors.chocolateNewDark,
                      fontSize: 16,
                    ),
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
