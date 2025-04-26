import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tekko/components/show_dialog_action.dart';
import 'package:tekko/features/api/data/bloc/activity/activity_bloc.dart';
import 'package:tekko/features/api/data/models/activity_kid_dto.dart';
import 'package:tekko/features/core/utils/format_date.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class AgendList extends StatefulWidget {
  final DateTime? selectedDate;

  const AgendList({super.key, required this.selectedDate});

  @override
  State<AgendList> createState() => _AgendListState();
}

class _AgendListState extends State<AgendList> {
  List<ActivityKidDto> activities = [];
  @override
  void initState() {
    super.initState();
    if (widget.selectedDate != null) {
      _getActivityData(widget.selectedDate!);
    }
  }

  @override
  void didUpdateWidget(covariant AgendList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate &&
        widget.selectedDate != null) {
      _getActivityData(widget.selectedDate!);
    }
  }

  Future<void> _getActivityData(DateTime selectedDate) async {
    try {
      final token = await StorageUtils.getString('token');
      final dateFilter =
          DateFormat('yyyy-MM-dd').format(selectedDate).toString();

      context
          .read<ActivityBloc>()
          .add(ActivityLoadKidRequested(dateFilter: dateFilter, token: token!));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> _updateActivityStatus(int activityId) async {
    try {
      final token = await StorageUtils.getString('token');

      context.read<ActivityBloc>().add(
          ActivityUpdateLoadRequested(activityId: activityId, token: token!));
      _getActivityData(widget.selectedDate!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _playSound() {
    final player = AudioPlayer();
    player.play(AssetSource('sounds/nivel/completed.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.chocolateCream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Eventos",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.chocolateNewDark,
                  ),
                ),
                Expanded(child: BlocBuilder<ActivityBloc, ActivityState>(
                    builder: (context, state) {
                  if (state is ActivitiesKidLoadSuccess) {
                    if (state.activities.isEmpty) {
                      return const Center(
                        child: Text('No hay actividades para esta fecha'),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.activities.length,
                      itemBuilder: (context, index) {
                        final activity = state.activities[index];

                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Bounce(
                              animate: activity.status != 'COMPLETED',
                              duration: const Duration(milliseconds: 800),
                              child: Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: activity.status == 'COMPLETED'
                                        ? AppColors.chocolateNewDark
                                        : AppColors.textColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: activity.status != 'COMPLETED'
                                        ? [
                                            BoxShadow(
                                              color: Colors.yellow
                                                  .withOpacity(0.5),
                                              blurRadius: 12,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 3),
                                            )
                                          ]
                                        : [],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                              decoration: BoxDecoration(
                                                color: activity.status ==
                                                        'COMPLETED'
                                                    ? AppColors.chocolateCream
                                                        .withOpacity(0.4)
                                                    : AppColors.chocolateCream,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    activity.titleActivity,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: activity.status ==
                                                              'COMPLETED'
                                                          ? AppColors
                                                              .cardMaskSoft
                                                          : AppColors
                                                              .chocolateNewDark,
                                                      decoration: activity
                                                                  .status ==
                                                              'COMPLETED'
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.emoji_events,
                                                        color:
                                                            Colors.amber[700],
                                                        size: 20,
                                                      ),
                                                      const SizedBox(width: 6),
                                                      Text(
                                                        '+${activity.experienceActivity} EXP',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .orange[800],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    children: [
                                                      // 🕒 Icono de inicio
                                                      Column(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .play_circle_fill,
                                                              color: activity
                                                                          .status ==
                                                                      'COMPLETED'
                                                                  ? AppColors
                                                                      .cardMaskSoft
                                                                  : Colors
                                                                      .green,
                                                              size: 32),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(
                                                            'Inicio',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: activity
                                                                          .status ==
                                                                      'COMPLETED'
                                                                  ? AppColors
                                                                      .cardMaskSoft
                                                                  : Colors
                                                                      .green,
                                                            ),
                                                          ),
                                                          Text(
                                                            formatDatePretty(
                                                                activity
                                                                    .startActivityTime),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: activity
                                                                          .status ==
                                                                      'COMPLETED'
                                                                  ? AppColors
                                                                      .cardMaskSoft
                                                                  : Colors
                                                                      .black87,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      TextButton.icon(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor: activity
                                                                      .status ==
                                                                  'COMPLETED'
                                                              ? AppColors
                                                                  .cardMaskSoft
                                                                  .withOpacity(
                                                                      0.3)
                                                              : Colors.redAccent
                                                                  .withOpacity(
                                                                      0.1),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 8),
                                                        ),
                                                        onPressed:
                                                            activity.status ==
                                                                    'COMPLETED'
                                                                ? null
                                                                : () async {
                                                                    await _updateActivityStatus(
                                                                        activity
                                                                            .activityId);
                                                                    _playSound();
                                                                    await _getActivityData(
                                                                        widget
                                                                            .selectedDate!);
                                                                  },
                                                        icon: Icon(
                                                          Icons.flag,
                                                          color: activity
                                                                      .status ==
                                                                  'COMPLETED'
                                                              ? AppColors
                                                                  .cardMaskSoft
                                                              : Colors
                                                                  .redAccent,
                                                          size: 20,
                                                        ),
                                                        label: Text(
                                                          'Finalizar',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: activity
                                                                        .status ==
                                                                    'COMPLETED'
                                                                ? AppColors
                                                                    .cardMaskSoft
                                                                : Colors
                                                                    .redAccent,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        formatDatePretty(activity
                                                            .expirationActivityTime),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: activity
                                                                      .status ==
                                                                  'COMPLETED'
                                                              ? AppColors
                                                                  .cardMaskSoft
                                                              : Colors.black87,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: AppColors.yellowButton),
                                    onPressed: () {
                                      showDialogAction(context, activity);
                                    },
                                  ),
                                ),
                              ]),
                            ));
                      },
                    );
                  } else if (state is ActivityLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ActivityError) {
                    return Center(child: Text('Error cargando Actividades'));
                  }
                  return const Center(child: CircularProgressIndicator());
                })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
