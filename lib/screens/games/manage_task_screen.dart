import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tekko/styles/app_colors.dart';

class ManageTaskScreen extends StatefulWidget {
  const ManageTaskScreen({super.key});

  @override
  State<ManageTaskScreen> createState() => _ManageTaskScreenState();
}

class _ManageTaskScreenState extends State<ManageTaskScreen> {
  // Datos de ejemplo (deberías reemplazarlos con los de tu API)
  final Map<String, dynamic> taskData = {
    "success": true,
    "message": "Se encontraron 4 tareas",
    "data": {
      "pendingTasks": 2,
      "tasks": [
        {
          "taskid": 1,
          "number1": "5",
          "number2": "3",
          "operation": "suma",
          "correctanswer": "8",
          "iscompleted": true,
          "childanswer": "8",
          "createdAt": "2023-05-15"
        },
        {
          "taskid": 2,
          "number1": "10",
          "number2": "4",
          "operation": "resta",
          "correctanswer": "6",
          "iscompleted": false,
          "childanswer": null,
          "createdAt": "2023-05-16"
        },
        {
          "taskid": 3,
          "number1": "7",
          "number2": "2",
          "operation": "multiplicacion",
          "correctanswer": "14",
          "iscompleted": true,
          "childanswer": "14",
          "createdAt": "2023-05-17"
        },
        {
          "taskid": 4,
          "number1": "12",
          "number2": "3",
          "operation": "division",
          "correctanswer": "4",
          "iscompleted": false,
          "childanswer": null,
          "createdAt": "2023-05-18"
        }
      ]
    }
  };

  // Estados para el filtrado
  String _filter = 'todas'; // 'todas', 'completadas', 'pendientes'

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pendingTasks = taskData['data']['pendingTasks'] ?? 0;
    final totalTasks = taskData['data']['tasks']?.length ?? 0;
    final completedTasks = totalTasks - pendingTasks;

    // Filtrar tareas según el estado seleccionado
    List<dynamic> filteredTasks = taskData['data']['tasks'].where((task) {
      if (_filter == 'completadas') return task['iscompleted'] == true;
      if (_filter == 'pendientes') return task['iscompleted'] == false;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Stack(
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
                            _buildFilterChip('Completadas', 'completadas'),
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
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'No se encontraron tareas',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      final isCompleted = task['iscompleted'] == true;

                      return BounceInUp(
                        duration: Duration(milliseconds: 500 + (index * 100)),
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
      ),
    );
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

  Widget _buildTaskCard(Map<String, dynamic> task, bool isCompleted) {
    final operationSymbol = _getOperationSymbol(task['operation']);
    final date = task['createdAt']?.toString().split(' ')[0] ?? '';

    return Card(
      elevation: isCompleted ? 2 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: isCompleted
          ? Colors.white.withOpacity(0.7) // Más transparente para completadas
          : AppColors.chocolateNewDark
              .withOpacity(0.9), // Más oscuro para pendientes
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tarea #${task['taskid']}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.grey.shade700 : Colors.white,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: isCompleted ? Colors.grey.shade500 : Colors.white70,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Operación matemática
            Center(
              child: Column(
                children: [
                  Text(
                    'Operación asignada',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          isCompleted ? Colors.grey.shade600 : Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        task['number1'],
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isCompleted
                              ? AppColors.chocolateNewDark
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        operationSymbol,
                        style: TextStyle(
                          fontSize: 28,
                          color:
                              isCompleted ? Colors.grey.shade600 : Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        task['number2'],
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isCompleted
                              ? AppColors.chocolateNewDark
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        '=',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        task['correctanswer'],
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isCompleted ? Colors.green : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (isCompleted) ...[
              const SizedBox(height: 15),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Respuesta del niño:',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    task['childanswer']?.toString() ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
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
        return '+';
    }
  }
}
