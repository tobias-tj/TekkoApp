import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/features/api/data/bloc/activity/activity_bloc.dart';
import 'package:tekko/features/api/data/models/form_activity_model.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class CreateActivityScreen extends StatefulWidget {
  const CreateActivityScreen({super.key});

  @override
  State<CreateActivityScreen> createState() => _CreateActivityScreenState();
}

class _CreateActivityScreenState extends State<CreateActivityScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startTime;
  DateTime? _endTime;

  int? _selectedExperience;

  void _pickDateTime({required bool isStart}) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2030),
      locale: LocaleType.es,
      onConfirm: (date) {
        setState(() {
          if (isStart) {
            _startTime = date;
          } else {
            _endTime = date;
          }
        });
      },
    );
  }

  void _submitForm() async {
    final childrenId = await StorageUtils.getInt('childrenId') ?? 0;
    final parentId = await StorageUtils.getInt('parentId') ?? 0;
    if (_formKey.currentState!.validate() &&
        _startTime != null &&
        _endTime != null) {
      final detail = Detail(
        startActivityTime: _startTime!,
        expirationActivityTime: _endTime!,
        titleActivity: _titleController.text,
        descriptionActivity: _descriptionController.text,
        experienceActivity: _selectedExperience ?? 0,
      );

      final formModel = FormActivityModel(
        detail: detail,
        childrenId: childrenId,
        parentId: parentId,
      );

      context
          .read<ActivityBloc>()
          .add(ActivityRequested(activityModel: formModel));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActivityBloc, ActivityState>(
      listener: (context, state) {
        if (state is ActivitySuccess) {
          // Limpiar campos
          _formKey.currentState?.reset();
          _titleController.clear();
          _descriptionController.clear();
          setState(() {
            _selectedExperience = null;
            _startTime = null;
            _endTime = null;
          });

          // Mostrar notificación
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('¡Actividad creada con éxito!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is ActivityError) {
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
          elevation: 0,
          title: FadeInRight(
            child: const Text(
              'Crear Nueva Actividad',
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
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Card para Título
                FadeInUp(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedText,
                                size: 28,
                                color: AppColors.chocolateNewDark,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Título de la Actividad',
                                style: TextStyle(
                                  color: AppColors.chocolateNewDark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: 'Ingrese el título de la actividad',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Este campo es requerido'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Card para Descripción
                FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedDocumentValidation,
                                size: 28,
                                color: AppColors.chocolateNewDark,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Descripción',
                                style: TextStyle(
                                  color: AppColors.chocolateNewDark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _descriptionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Describa la actividad...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Card para Experiencia
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedStar,
                                size: 28,
                                color: AppColors.chocolateNewDark,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Puntos de Experiencia',
                                style: TextStyle(
                                  color: AppColors.chocolateNewDark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<int>(
                            value: _selectedExperience,
                            decoration: InputDecoration(
                              hintText: 'Seleccione los puntos',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: List.generate(50, (index) {
                              final value = index + 1;
                              return DropdownMenuItem(
                                value: value,
                                child: Text('$value puntos'),
                              );
                            }),
                            onChanged: (value) {
                              setState(() {
                                _selectedExperience = value;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Este campo es requerido'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Card para Fecha de Inicio
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedCalendarAdd01,
                                size: 28,
                                color: AppColors.chocolateNewDark,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Fecha y Hora de Inicio',
                                style: TextStyle(
                                  color: AppColors.chocolateNewDark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            title: Text(
                              _startTime != null
                                  ? 'Inicio: ${_startTime!.toLocal()}'
                                  : 'Seleccionar fecha y hora',
                              style: TextStyle(
                                color: _startTime != null
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            trailing: Icon(
                              Icons.calendar_today,
                              color: AppColors.chocolateNewDark,
                            ),
                            onTap: () => _pickDateTime(isStart: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Card para Fecha de Vencimiento
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedCalendarCheckIn01,
                                size: 28,
                                color: AppColors.chocolateNewDark,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Fecha y Hora de Vencimiento',
                                style: TextStyle(
                                  color: AppColors.chocolateNewDark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            title: Text(
                              _endTime != null
                                  ? 'Vencimiento: ${_endTime!.toLocal()}'
                                  : 'Seleccionar fecha y hora',
                              style: TextStyle(
                                color: _endTime != null
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            trailing: Icon(
                              Icons.calendar_today,
                              color: AppColors.chocolateNewDark,
                            ),
                            onTap: () => _pickDateTime(isStart: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Botones de acción
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.chocolateNewDark,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Crear Actividad',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextButton(
                          onPressed: () => context.goNamed('adminHome'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: AppColors.chocolateNewDark,
                                width: 2,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              color: AppColors.chocolateNewDark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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
