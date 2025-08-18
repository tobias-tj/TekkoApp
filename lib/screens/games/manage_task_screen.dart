import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/features/api/data/bloc/task/task_bloc.dart';
import 'package:tekko/features/api/data/models/get_task_dto.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:tekko/utils/get_operation_symbol.dart';

class ManageTaskScreen extends StatefulWidget {
  const ManageTaskScreen({super.key});

  @override
  State<ManageTaskScreen> createState() => _ManageTaskScreenState();
}

class _ManageTaskScreenState extends State<ManageTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getTaskData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TaskBloc>().stream.listen((state) {
      if (state is TaskSuccess) {
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

  Future<void> _deleteTaskData() async {
    try {
      final token = await StorageUtils.getString('token');

      context.read<TaskBloc>().add(TaskDeleteRequested(token: token!));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se ha logrado eliminar las tareas')),
      );
    }
  }

  // Estados para el filtrado
  String _filter = 'todas'; // 'todas', 'completadas', 'pendientes'

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.softCream,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.chocolateNewDark,
          onPressed: () => context.pushNamed('createTask'),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskGetSuccess) {
            final taskData = state.tasks;
            final pendingTasks = taskData.pendingTasks;
            final totalTasks = (taskData.taskList).length;
            final completedTasks = totalTasks - pendingTasks;

            List<dynamic> filteredTasks = taskData.taskList.where((task) {
              if (_filter == 'completadas') return task.iscompleted == true;
              if (_filter == 'pendientes') return task.iscompleted == false;
              return true;
            }).toList();

            return Stack(
              children: [
                // Fondo decorativo animado
                Positioned(
                  top: 0,
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Image.asset(
                      'assets/images/topTitleAccount.png',
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),

                      // Título y estadísticas
                      FadeInDown(
                        duration: const Duration(milliseconds: 500),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gestión de Tareas',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.softCream,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Visualiza y administra las tareas asignadas',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.softCream,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.chocolateNewDark,
                                foregroundColor: AppColors.chocolateDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                elevation: 3,
                              ),
                              icon: Icon(HugeIcons.strokeRoundedDelete02,
                                  color: Colors.redAccent, size: 22),
                              label: Text(
                                'Borrar todo',
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                // Acción para borrar todas las tareas
                                _deleteTaskData();
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Tarjetas de resumen
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildSummaryCard(
                                title: 'Completadas',
                                value: completedTasks,
                                color: Colors.green,
                                icon: Icons.check_circle,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildSummaryCard(
                                title: 'Pendientes',
                                value: pendingTasks,
                                color: Colors.orange,
                                icon: Icons.pending,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Filtros
                      FadeInUp(
                        duration: const Duration(milliseconds: 700),
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildFilterChip('Todas', 'todas'),
                                  const SizedBox(width: 10),
                                  _buildFilterChip(
                                      'Completadas', 'completadas'),
                                  const SizedBox(width: 10),
                                  _buildFilterChip('Pendientes', 'pendientes'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Lista de tareas
                      if (filteredTasks.isEmpty)
                        FadeIn(
                          child: Card(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      "assets/animations/dogChill.json",
                                      repeat: true,
                                      width: 180,
                                      height: 180,
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      'No se encontraron tareas pendientes',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade600,
                                      ),
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
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = filteredTasks[index] as Tasks;
                            final isCompleted = task.iscompleted;

                            return BounceInUp(
                              duration:
                                  Duration(milliseconds: 500 + (index * 100)),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: _buildTaskCard(task, isCompleted),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is TaskError) {
            return Center(
              child: Text('Error al cargar tareas',
                  style: TextStyle(color: Colors.red)),
            );
          }
          return const SizedBox();
        }));
  }

  Widget _buildSummaryCard({
    required String title,
    required int value,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Icon(icon, size: 20, color: color),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filter == value;
    return InkWell(
      onTap: () => setState(() => _filter = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.chocolateNewDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected ? AppColors.chocolateNewDark : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(Tasks task, bool isCompleted) {
    final operationSymbol = getOperationSymbol(task.operation);

    return Card(
      elevation: isCompleted ? 2 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: isCompleted
          ? Colors.green.withOpacity(0.5)
          : Colors.orange.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tarea #${task.taskid}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // Si tu modelo `Tasks` no tiene fecha, puedes omitir esto o usar una fecha dummy
                // Text('Fecha'),
              ],
            ),
            const SizedBox(height: 15),
            Center(
              child: Column(
                children: [
                  Text(
                    'Operación asignada',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        task.number1.toString(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        operationSymbol,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        task.number2.toString(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (task.childanswer != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Respuesta obtenida:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          task.childanswer.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
