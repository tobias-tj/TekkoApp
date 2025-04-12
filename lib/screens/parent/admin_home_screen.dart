import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tekko/components/admin/custom_calendar.dart';
import 'package:tekko/components/admin/task_card.dart';
import 'package:tekko/features/api/data/bloc/activity/activity_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  DateTime? _selectedDate;
  String _filter = 'All';

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _getActivityData();
  }

  Future<void> _getActivityData() async {
    try {
      final parentId = await StorageUtils.getInt('parentId') ?? 0;
      final dateFilter = DateFormat('yyyy-MM-dd').format(_selectedDate!);

      context.read<ActivityBloc>().add(
            ActivitiesLoadRequested(
              dateFilter: dateFilter,
              parentId: parentId,
              statusFilter: _filter == 'All' ? null : _filter,
            ),
          );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.chocolateNewDark,
        onPressed: () => context.goNamed('createActivity'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Encabezado con el calendario
              SizedBox(
                height: size.height * 0.4 + 120,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: size.height * 0.2,
                        color: AppColors.chocolateNewDark,
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Gesto Actividades",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.softCreamDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 95,
                      left: 0,
                      right: 0,
                      child: CustomCalendar(
                        onDateSelected: (date) {
                          setState(() {
                            _selectedDate = date;
                          });
                          _getActivityData(); // Actualiza actividades al cambiar fecha
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Sección de filtros y fecha
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Actividades",
                          style: TextStyle(color: AppColors.chocolateNewDark),
                        ),
                        DropdownButton<String>(
                          value: _filter,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _filter = newValue;
                              });
                              _getActivityData(); // Actualiza actividades con el filtro seleccionado
                            }
                          },
                          items: <String>['All', 'COMPLETED', 'PENDING']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          style: TextStyle(
                            color: AppColors.chocolateNewDark,
                          ),
                          iconEnabledColor: AppColors.chocolateNewDark,
                        ),
                      ],
                    ),
                    if (_selectedDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          DateFormat('EEEE, d MMMM y', 'es')
                              .format(_selectedDate!),
                          style: TextStyle(
                            color: AppColors.chocolateNewDark,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Lista de actividades
              Expanded(
                child: BlocBuilder<ActivityBloc, ActivityState>(
                  builder: (context, state) {
                    if (state is ActivitiesLoadSuccess) {
                      if (state.activities.isEmpty) {
                        return const Center(
                          child: Text('No hay actividades para esta fecha'),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.activities.length,
                        itemBuilder: (context, index) {
                          final activity = state.activities[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: TaskCard(
                              title: activity.titleActivity,
                              description: activity.descriptionActivity,
                              xp: activity.experienceActivity,
                              startTime: activity.startActivityTime,
                              endTime: activity.expirationActivityTime,
                              completed: activity.status == 'COMPLETED',
                            ),
                          );
                        },
                      );
                    } else if (state is ActivityLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ActivityError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
