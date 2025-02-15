import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class AgendList extends StatefulWidget {
  const AgendList({super.key});

  @override
  State<AgendList> createState() => _AgendListState();
}

class _AgendListState extends State<AgendList> {
  // Mock de tareas
  final List<Map<String, dynamic>> tasks = [
    {"title": "Matemáticas", "exp": 10, "time": "08:00 AM", "done": false},
    {"title": "Inglés", "exp": 5, "time": "10:00 AM", "done": false},
    {"title": "Ciencias", "exp": 8, "time": "12:00 PM", "done": false},
    {"title": "Historia", "exp": 6, "time": "03:00 PM", "done": false},
    {"title": "Deporte", "exp": 7, "time": "05:00 PM", "done": false},
  ];

  // Método para marcar una tarea como completada
  void toggleTask(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.chocolateCream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Eventos",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.chocolateNewDark,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          color: AppColors.textColor,
                          child: Row(
                            children: [
                              // CheckBox para completar la tarea
                              Checkbox(
                                value: task["done"],
                                activeColor: AppColors.chocolateDark,
                                onChanged: (value) => toggleTask(index),
                              ),
                              const SizedBox(width: 10),
                              // Información de la tarea
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${task['title']} +${task['exp']} EXP",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: task["done"]
                                            ? Colors.grey
                                            : AppColors.chocolateDark,
                                        decoration: task["done"]
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      task["time"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.chocolateNewDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
