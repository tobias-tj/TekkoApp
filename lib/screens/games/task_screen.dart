import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/features/api/data/bloc/task/task_bloc.dart';
import 'package:tekko/features/api/data/models/get_task_dto.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:tekko/utils/get_operation_symbol.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    _getTaskData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TaskBloc>().stream.listen((state) {
      if (state is TaskUpdateSuccess) {
        _getTaskData();
      }
      if (state is TaskError) {
        _getTaskData();
      }
    });
  }

  Future<void> _getTaskData() async {
    try {
      final token = await StorageUtils.getString('token');
      context.read<TaskBloc>().add(TaskGetRequested(token: token!));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se ha logrado obtener tareas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        title: const Text(
          'Tareas por Completar',
          style: TextStyle(
              color: AppColors.textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.softCreamDark,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskGetSuccess) {
          final taskData = state.tasks;

          List<dynamic> tasks = taskData.taskList
              .where((task) => task.iscompleted == false)
              .toList();

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  if (tasks.isEmpty)
                    Center(
                      child: BounceInUp(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(
                                  "assets/animations/dogChill.json",
                                  repeat: true,
                                  width: 180,
                                  height: 180,
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  '¡Ya completaste todas tus tareas!',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.chocolateNewDark,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index] as Tasks;
                        return ElasticIn(
                          duration: Duration(milliseconds: 500 + index * 100),
                          child: GestureDetector(
                            onTap: () {
                              context.pushNamed('answerTask', extra: task);
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
          );
        } else if (state is TaskError) {
          return Center(
            child: Text('Error al cargar tareas',
                style: TextStyle(color: Colors.red)),
          );
        }
        return const SizedBox();
      }),
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

  Widget _buildTaskCard(Tasks task) {
    final operation = getOperationSymbol(task.operation);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '🧠 Tarea #${task.taskid}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${task.number1} $operation ${task.number2}',
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
}
