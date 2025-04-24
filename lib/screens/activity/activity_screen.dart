import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/components/top_custom_title.dart';
import 'package:tekko/features/api/data/bloc/activity/activity_bloc.dart';
import 'package:tekko/features/api/data/bloc/task/task_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    super.initState();
    _getTaskData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ActivityBloc>().stream.listen((state) {
      if (state is ActivitySuccess) {
        _getTaskData();
      }
      if (state is ActivityError) {
        _getTaskData();
      }
    });
  }

  Future<void> _getTaskData() async {
    try {
      final childrenId = await StorageUtils.getInt('childrenId') ?? 0;
      context.read<TaskBloc>().add(TaskGetRequested(childrenId: childrenId));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se ha logrado obtener tareas')),
      );
    }
  }

  final List<Map<String, dynamic>> games = [
    {
      "title": "Dibujo Libre",
      "image": "assets/images/activities/paintIcon.png",
      "route": "/drawing"
    },
    {
      "title": "Tareas",
      "image": "assets/images/activities/numberIcon.png",
      "route": "/tasks"
    },
    {
      "title": "Memorias",
      "image": "assets/images/activities/readIcon.png",
      "route": "/memory"
    }
  ];

  late int incompleteTaskCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.softCream,
        body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskGetSuccess) {
            final taskData = state.tasks;
            incompleteTaskCount = taskData.pendingTasks;

            return Column(
              children: [
                TopCustomTitle(title: 'Actividades'),
                const SizedBox(height: 6),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        final game = games[index];
                        if (game["title"] == "Tareas") {
                          return GestureDetector(
                            onTap: () => context.go(game["route"]),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 6,
                                child: ListTile(
                                  leading: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Image.asset(game["image"]!, width: 50),
                                      Text(
                                        '$incompleteTaskCount',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Text(game["title"]!,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (incompleteTaskCount > 0)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            '$incompleteTaskCount',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      const Icon(Icons.play_arrow,
                                          color: AppColors.chocolateNewDark),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () => context.go(game["route"]),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 4,
                              child: ListTile(
                                leading: Image.asset(game["image"]!, width: 50),
                                title: Text(game["title"]!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                trailing: const Icon(Icons.play_arrow,
                                    color: AppColors.chocolateNewDark),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
}
