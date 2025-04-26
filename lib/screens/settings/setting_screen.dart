import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tekko/components/linear_element.dart';
import 'package:tekko/components/profile_icon_manager.dart';
import 'package:tekko/components/top_title_generic.dart';
import 'package:tekko/features/api/data/bloc/setting/setting_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    _loadProfileIcon();
    _getSettingData();
  }

  Future<String> _loadProfileIcon() async {
    return await ProfileIconManager.getSelectedIcon();
  }

  Future<void> _getSettingData() async {
    try {
      final token = await StorageUtils.getString('token');

      context.read<SettingBloc>().add(SettingProfileRequested(token: token!));
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/topTitleAccount.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Título con animación de rebote
                BounceInDown(
                  duration: const Duration(milliseconds: 800),
                  child: const TopTitleGeneric(
                    title: "Mis Ajustes",
                  ),
                ),

                const SizedBox(height: 25),

                // Tarjeta principal con efecto de aparición
                ElasticIn(
                  duration: const Duration(milliseconds: 900),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      color: AppColors.cardBackgroundSoft,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // Avatar y datos del niño con animación escalonada
                            FadeInLeft(
                              duration: const Duration(milliseconds: 600),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FutureBuilder<String>(
                                    future: _loadProfileIcon(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                          ),
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                      return Bounce(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        infinite: true,
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage(
                                            snapshot.data ??
                                                "assets/images/dogJake.png",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  BlocBuilder<SettingBloc, SettingState>(
                                    builder: (context, state) {
                                      if (state is SettingProfileSuccess) {
                                        final profile = state.detailsProfileDto;
                                        return ElasticIn(
                                          duration:
                                              const Duration(milliseconds: 800),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                profile.childName,
                                                style: const TextStyle(
                                                  color: AppColors
                                                      .chocolateNewDark,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                profile.email,
                                                style: const TextStyle(
                                                  color: AppColors
                                                      .chocolateNewDark,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (state is SettingLoading) {
                                        return const CircularProgressIndicator();
                                      }
                                      return const Text("Mis datos");
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Línea divisora animada
                            Swing(
                              duration: const Duration(milliseconds: 1200),
                              child: LinearElement(size: size),
                            ),

                            const SizedBox(height: 20),

                            // Botón de modo padres con animación llamativa
                            Pulse(
                              duration: const Duration(milliseconds: 1500),
                              infinite: false,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.pushReplacement('/parentModePin');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.chocolateNewDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 12,
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.orange.withOpacity(0.5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Modo Papás",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Image.asset(
                                      "assets/images/parentIcon.png",
                                      width: 40,
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
