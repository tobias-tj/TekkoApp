import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/features/api/data/bloc/task/task_bloc.dart';
import 'package:tekko/features/api/data/models/create_task_model.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tekko/utils/get_operation_symbol.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  String _selectedOperation = 'suma';
  bool _isSaving = false;
  final List<TextEditingController> _numberControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final TextEditingController _answerController = TextEditingController();

  @override
  void dispose() {
    for (var controller in _numberControllers) {
      controller.dispose();
    }
    _answerController.dispose();
    super.dispose();
  }

  void _onOperationChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedOperation = value;
      });
    }
  }

  void _saveTask() async {
    if (_isSaving) return;
    // Validar campos vacíos
    if (_numberControllers[0].text.isEmpty ||
        _numberControllers[1].text.isEmpty ||
        _answerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Por favor complete todos los campos'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Validar que sean números válidos
    final number1 = int.tryParse(_numberControllers[0].text);
    final number2 = int.tryParse(_numberControllers[1].text);
    final answer = int.tryParse(_answerController.text);

    if (number1 == null || number2 == null || answer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Por favor ingrese números válidos'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Validación específica para división
    if (_selectedOperation == 'division' && number2 == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ No se puede dividir por cero'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Mostrar mensaje
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() {
      _isSaving = true; // Activar estado de carga
    });

    try {
      final token = await StorageUtils.getString('token');

      final formModel = CreateTaskModel(
        token: token!,
        number1: number1,
        number2: number2,
        operation: _selectedOperation,
        correctAnswer: answer,
      );

      context.read<TaskBloc>().add(TaskRequested(taskModel: formModel));
    } catch (e) {
      scaffoldMessenger.hideCurrentSnackBar();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('❌ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildNumberInput(int index, {int delay = 0}) {
    return ElasticIn(
      delay: Duration(milliseconds: delay),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: TextField(
            controller: _numberControllers[index],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskSuccess) {
          for (var controller in _numberControllers) {
            controller.clear();
          }
          _answerController.clear();

          setState(() {
            _isSaving = false; // Desactivar carga al tener éxito
          });

          // Mensaje
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
          backgroundColor: AppColors.softCream,
          elevation: 0,
          title: FadeInRight(
            child: const Text(
              'Crear Nueva Tarea',
              style: TextStyle(
                color: AppColors.chocolateNewDark,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          leading: IconButton(
            icon: FadeInLeft(
              child: const Icon(Icons.arrow_back,
                  color: AppColors.chocolateNewDark, size: 28),
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              ZoomIn(
                delay: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Números de la operación
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildNumberInput(0, delay: 100),
                          const SizedBox(width: 20),
                          JelloIn(
                            delay: const Duration(milliseconds: 200),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                getOperationSymbol(_selectedOperation),
                                style: const TextStyle(
                                  fontSize: 48,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          _buildNumberInput(1, delay: 300),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Línea divisoria
                      SlideInLeft(
                        delay: const Duration(milliseconds: 600),
                        child: Container(
                          height: 3,
                          width: MediaQuery.of(context).size.width * 0.7,
                          color: Colors.grey.shade400,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Campo para la respuesta
                      BounceInDown(
                        delay: const Duration(milliseconds: 700),
                        child: Container(
                          width: 180,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: TextField(
                              controller: _answerController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '=',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                              ),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Selector de operación
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.orange.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.5,
                          children: [
                            _buildOperationButton('suma', Icons.add),
                            _buildOperationButton('resta', Icons.remove),
                            _buildOperationButton(
                                'multiplicacion', Icons.close),
                            _buildOperationButton('division', Icons.percent),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: ElasticIn(
                  child: SafeArea(
                    top: false,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSaving
                            ? Colors.orange.withOpacity(0.7)
                            : Colors.orange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 10,
                        shadowColor: Colors.orange.withOpacity(0.5),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.save,
                                  size: 24,
                                  color: AppColors.textColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Guardar Tarea',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textColor),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOperationButton(String operation, IconData icon) {
    final isSelected = _selectedOperation == operation;
    return Bounce(
      duration: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () => _onOperationChanged(operation),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: isSelected ? Colors.orange.shade800 : Colors.grey.shade200,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 30,
                color: isSelected ? Colors.white : Colors.orange,
              ),
              const SizedBox(height: 5),
              Text(
                operation.capitalize(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
