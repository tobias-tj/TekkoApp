import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tekko/components/dialog_home.dart';
import 'package:tekko/components/profile_icon_manager.dart';
import 'package:tekko/features/api/data/bloc/experience/experience_bloc.dart';
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
      final token = await StorageUtils.getString('token');

      context.read<ExperienceBloc>().add(FetchExperienceEvent(token!));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  double _calculateProgressFactor(int exp, int expNextLevel) {
    if (expNextLevel <= 0) return 1.0;
    return exp / (exp + expNextLevel);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ExperienceBloc, ExperienceState>(
      builder: (context, state) {
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
              // Fondo con animación
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: FadeIn(
                  child: Container(
                    height: size.height * 0.2,
                    color: AppColors.chocolateNewDark,
                  ),
                ),
              ),

              // Contenido con animaciones separadas
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icono de perfil con animación
                    FadeInLeft(
                      duration: const Duration(milliseconds: 600),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: PopupMenuButton<String>(
                          onSelected: _changeProfileIcon,
                          itemBuilder: (context) {
                            final iconPaths = [
                              'assets/images/iconProfile.png',
                              'assets/images/animals-hd.png',
                              'assets/images/dogJake.png'
                            ];

                            return List.generate(iconPaths.length, (index) {
                              final iconPath = iconPaths[index];
                              return PopupMenuItem<String>(
                                value: iconPath,
                                child: Row(
                                  children: [
                                    Image.asset(iconPath, width: 40),
                                    const SizedBox(width: 8),
                                    Text('Perfil ${index + 1}'),
                                  ],
                                ),
                              );
                            });
                          },
                          child: Image.asset(
                            _selectedIcon,
                            fit: BoxFit.fill,
                            width: 45,
                            height: 45,
                          ),
                        ),
                      ),
                    ),

                    // Nivel y progreso con animación
                    FadeInDown(
                      duration: const Duration(milliseconds: 700),
                      child: Column(
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
                    ),

                    // Experiencia con animación
                    FadeInRight(
                      duration: const Duration(milliseconds: 600),
                      child: Padding(
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
                    ),
                  ],
                ),
              ),

              // DialogHome con animación
              Positioned(
                top: 140,
                left: 0,
                right: 0,
                child: FadeInUp(
                  duration: Duration(milliseconds: 800),
                  child: DialogHome(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
