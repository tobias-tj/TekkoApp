import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/features/api/data/bloc/task/task_bloc.dart';
import 'package:tekko/features/api/data/models/get_task_dto.dart';
import 'package:tekko/features/api/data/models/update_task_status_dto.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:tekko/utils/get_operation_symbol.dart';

class AnswerTaskScreen extends StatefulWidget {
  final Tasks task;

  const AnswerTaskScreen({super.key, required this.task});

  @override
  State<AnswerTaskScreen> createState() => _AnswerTaskScreenState();
}

class _AnswerTaskScreenState extends State<AnswerTaskScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitAnswer(int taskId) async {
    if (_isSaving) return;
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Por favor ingrese una respuesta'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final childAnswer = int.tryParse(_controller.text);

    if (childAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Por favor ingrese números válidos'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });
    try {
      final token = await StorageUtils.getString('token');

      final updateTaskModel = UpdateTaskStatusDto(
          token: token!, childAnswer: childAnswer, taskId: taskId);

      context
          .read<TaskBloc>()
          .add(TaskUpdateRequested(updateTaskStatusDto: updateTaskModel));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se ha logrado obtener tareas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final operationSymbol = getOperationSymbol(task.operation);

    return BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskUpdateSuccess) {
            _controller.clear();

            setState(() {
              _isSaving = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✓ Tarea guardada exitosamente'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
              ),
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                context.goNamed('tasks');
              }
            });
          } else if (state is TaskError) {
            setState(() {
              _isSaving = false; // Desactivar carga al tener éxito
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.softCream,
          appBar: AppBar(
            backgroundColor: AppColors.softCreamDark,
            title: const Text("Resolver Tarea"),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
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
                                'Tarea #${task.taskid}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${task.number1} $operationSymbol ${task.number2}',
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
                                onPressed: _isSaving
                                    ? null
                                    : () => _submitAnswer(task.taskid),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isSaving
                                      ? Colors.green.withOpacity(0.7)
                                      : Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: _isSaving
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            color: AppColors.textColor,
                                            strokeWidth: 2),
                                      )
                                    : const Text(
                                        'Guardar Respuesta',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textColor),
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
              ],
            ),
          ),
        ));
  }
}
