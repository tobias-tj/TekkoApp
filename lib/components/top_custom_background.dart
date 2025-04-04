import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekko/components/dialog_home.dart';
import 'package:tekko/components/profile_icon_manager.dart';
import 'package:tekko/features/auth/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class TopCustomBackground extends StatefulWidget {
  const TopCustomBackground({super.key});

  @override
  State<TopCustomBackground> createState() => _TopCustomBackgroundState();
}

class _TopCustomBackgroundState extends State<TopCustomBackground> {
  String _selectedIcon = 'assets/images/iconProfile.png';

  @override
  void initState() {
    super.initState();
    _loadProfileIcon();
    _getExperienceData();
  }

  Future<void> _loadProfileIcon() async {
    final icon = await ProfileIconManager.getSelectedIcon();
    setState(() {
      _selectedIcon = icon;
    });
  }

  void _changeProfileIcon(String newIcon) async {
    await ProfileIconManager.saveSelectedIcon(newIcon);
    setState(() {
      _selectedIcon = newIcon;
    });
  }

  Future<void> _getExperienceData() async {
    try {
      final childrenId = await StorageUtils.getInt('childrenId') ?? 0;
      if (childrenId > 0) {
        context.read<ExperienceBloc>().add(FetchExperienceEvent(childrenId));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  double _calculateProgressFactor(int exp, int expNextLevel) {
    if (expNextLevel <= 0) return 1.0; // Si ya es el nivel máximo
    return exp / (exp + expNextLevel);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ExperienceBloc, ExperienceState>(
      builder: (context, state) {
        // Datos por defecto
        int currentLevel = 1;
        int currentExp = 0;
        int expNextLevel = 40;
        double progressFactor = 0.0;

        if (state is ExperienceLoaded) {
          currentLevel = state.experience.level;
          currentExp = state.experience.exp;
          expNextLevel = state.experience.expNextlevel;
          progressFactor = _calculateProgressFactor(currentExp, expNextLevel);
        }

        return SizedBox(
          height: size.height * 0.4,
          child: Stack(
            children: [
              // Fondo recto
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: size.height * 0.2,
                  color: AppColors.chocolateNewDark,
                ),
              ),

              // Contenido (izquierda, centro, derecha)
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Izquierda: Icono de perfil
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: PopupMenuButton<String>(
                        onSelected: _changeProfileIcon,
                        itemBuilder: (context) => [
                          'assets/images/iconProfile.png',
                          'assets/images/animalsIcon.png',
                          'assets/images/dogJake.png'
                        ].map((iconPath) {
                          return PopupMenuItem<String>(
                            value: iconPath,
                            child: Row(
                              children: [
                                Image.asset(iconPath, width: 40),
                                const SizedBox(width: 8),
                                const Text('Icono'),
                              ],
                            ),
                          );
                        }).toList(),
                        child: Image.asset(
                          _selectedIcon,
                          fit: BoxFit.fill,
                          width: 45,
                          height: 45,
                        ),
                      ),
                    ),

                    // Centro: Nivel y barra de progreso
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nivel $currentLevel",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.softCreamDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 150,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progressFactor,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.chocolateDark,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Nivel De Progreso",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.softCreamDark,
                          ),
                        ),
                      ],
                    ),

                    // Derecha: Experiencia actual
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/iconStar.png',
                            width: 38,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${currentExp}XP",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.softCreamDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // DialogHome
              const Positioned(
                top: 140,
                left: 0,
                right: 0,
                child: DialogHome(),
              ),
            ],
          ),
        );
      },
    );
  }
}
