import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/styles/app_colors.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final Map<String, dynamic> taskData = const {
    "success": true,
    "message": "Se encontraron 4 tareas",
    "data": {
      "pendingTasks": 2,
      "tasks": [
        {
          "taskid": 2,
          "number1": "10",
          "number2": "4",
          "operation": "resta",
          "correctanswer": "6",
          "iscompleted": false,
          "childanswer": null,
        },
        {
          "taskid": 4,
          "number1": "12",
          "number2": "3",
          "operation": "division",
          "correctanswer": "4",
          "iscompleted": false,
          "childanswer": null,
        }
      ]
    }
  };

  @override
  Widget build(BuildContext context) {
    final tasks = taskData['data']['tasks']
        .where((task) => task['iscompleted'] == false)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        title: const Text('Tareas por Completar'),
        backgroundColor: AppColors.softCreamDark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              if (tasks.isEmpty)
                FadeIn(
                  child: Column(
                    children: const [
                      Icon(Icons.celebration, size: 80, color: Colors.green),
                      SizedBox(height: 15),
                      Text(
                        '¡Ya completaste todas tus tareas!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ElasticIn(
                      duration: Duration(milliseconds: 500 + index * 100),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .pushNamed('answerTask', extra: {'task': task});
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: _buildTaskCard(task),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushReplacement('/home');
        },
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.home,
          color: AppColors.textColor,
        ),
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    final operation = _getOperationSymbol(task['operation']);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '🧠 Tarea #${task['taskid']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${task['number1']} $operation ${task['number2']}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '¡Toca para resolver!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getOperationSymbol(String operation) {
    switch (operation) {
      case 'suma':
        return '+';
      case 'resta':
        return '-';
      case 'multiplicacion':
        return '×';
      case 'division':
        return '÷';
      default:
        return '?';
    }
  }
}
