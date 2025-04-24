import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/styles/app_colors.dart';

class AnswerTaskScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  const AnswerTaskScreen({super.key, required this.task});

  @override
  State<AnswerTaskScreen> createState() => _AnswerTaskScreenState();
}

class _AnswerTaskScreenState extends State<AnswerTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final operationSymbol = _getOperationSymbol(task['operation']);

    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        backgroundColor: AppColors.softCreamDark,
        title: const Text("Resolver Tarea"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Lottie.asset(
                "assets/animations/homework.json",
                repeat: true,
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 30),

              // "Pizarra blanca"
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 8,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        'Tarea #${task['taskid']}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${task['number1']} $operationSymbol ${task['number2']}',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Escribí tu respuesta...',
                          filled: true,
                          fillColor: AppColors.softCream,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Guardar Respuesta',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.textColor),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitAnswer() {
    // TODO: falta desarrollo para guardar respuesta
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
