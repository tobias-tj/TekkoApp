import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:go_router/go_router.dart';
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
          appBar: AppBar(title: const Text('Crear Actividad')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      prefixIcon: Icon(Icons.title),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Este campo es requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    value: _selectedExperience,
                    decoration: const InputDecoration(
                      labelText: 'Experiencia',
                      prefixIcon: Icon(Icons.star),
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(50, (index) {
                      final value = index + 1;
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        _selectedExperience = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Este campo es requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(
                      _startTime != null
                          ? 'Inicio: ${_startTime!.toLocal()}'
                          : 'Seleccionar fecha y hora de inicio',
                    ),
                    leading: const Icon(Icons.event_available),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _pickDateTime(isStart: true),
                  ),
                  ListTile(
                    title: Text(
                      _endTime != null
                          ? 'Expira: ${_endTime!.toLocal()}'
                          : 'Seleccionar fecha y hora de vencimiento',
                    ),
                    leading: const Icon(Icons.schedule),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _pickDateTime(isStart: false),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.textColor,
                    ),
                    onPressed: _submitForm,
                    label: const Text('Crear Actividad'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.chocolateNewDark,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () => context.goNamed('adminHome'),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppColors.chocolateNewDark,
                    ),
                    label: const Text(
                      'Cancelar',
                      style: TextStyle(color: AppColors.chocolateNewDark),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
