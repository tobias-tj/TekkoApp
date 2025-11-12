import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tekko/components/list_card_item_home.dart';
import 'package:tekko/components/top_custom_background.dart';
import 'package:tekko/data/list_item_home.dart';
import 'package:tekko/features/api/data/bloc/activity/activity_bloc.dart';
import 'package:tekko/features/api/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/features/api/data/bloc/task/task_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/features/services/firebase_message.dart';
import 'package:tekko/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> items = ItemData.getAll();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _getTaskData();
    await _getActivityData(selectedDate);
  }

  Future<void> _getTaskData() async {
    try {
      final token = await StorageUtils.getString('token');
      if (token == null) throw Exception('Token no encontrado');

      context.read<TaskBloc>().add(TaskGetFromHomeRequested(token: token));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se ha logrado obtener tareas')),
        );
      }
    }
  }

  Future<void> _getActivityData(DateTime date) async {
    try {
      final token = await StorageUtils.getString('token');
      if (token == null) throw Exception('Token no encontrado');

      final dateFilter = DateFormat('yyyy-MM-dd').format(date);
      context
          .read<ActivityBloc>()
          .add(ActivityLoadKidRequested(dateFilter: dateFilter, token: token));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar actividades: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: MultiBlocListener(
        listeners: [
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is TaskGetHomeSuccess) {
                final taskData = state.tasks;
                if (taskData.pendingTasks > 0) {
                  FirebaseMessageService.showLocalNotification(
                    title: 'Hora de jugar y aprender! 🎉',
                    body:
                        '¡Desbloquea tu siguiente nivel resolviendo las operaciones matemáticas!',
                    payload: 'tasks',
                  );
                }
              }
            },
          ),
          BlocListener<ActivityBloc, ActivityState>(
            listener: (context, state) {
              if (state is ActivitiesKidLoadSuccess &&
                  state.activities.isNotEmpty) {
                FirebaseMessageService.showLocalNotification(
                  title: '¡Tienes actividades para hoy! 🎉',
                  body: 'Ve al calendario y completa tus desafíos.',
                  payload: 'calendar',
                );
              }
            },
          ),
        ],
        child: Column(
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: const TopCustomBackground(),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<ExperienceBloc, ExperienceState>(
                builder: (context, state) {
                  if (state is ExperienceLoaded) {
                    final levelCurrent = state.experience.level;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isLocked = levelCurrent < item.level;

                          return FadeInUp(
                            duration: Duration(milliseconds: 500 + index * 100),
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: isLocked ? 0.5 : 1.0,
                                  child: IgnorePointer(
                                    ignoring: isLocked,
                                    child: ListCardItemHome(
                                      id: item.id,
                                      imagePath: item.imagePath,
                                      title: item.title,
                                    ),
                                  ),
                                ),
                                if (isLocked)
                                  const Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.lock,
                                        size: 40,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
