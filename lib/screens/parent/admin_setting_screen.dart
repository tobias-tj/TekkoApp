import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tekko/components/linear_element.dart';
import 'package:tekko/components/profile_icon_manager.dart';
import 'package:tekko/components/top_title_generic.dart';
import 'package:tekko/features/api/data/bloc/setting/setting_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/screens/settings/item_setting.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({super.key});

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  @override
  void initState() {
    super.initState();
    _loadProfileIcon();
    _getSettingData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SettingBloc>().stream.listen((state) {
      if (state is SettingUpdateProfileSuccess ||
          state is SettingUpdatePinTokenSuccess) {
        _getSettingData();
      }
      if (state is SettingError) {
        _getSettingData();
      }
    });
  }

  Future<String> _loadProfileIcon() async {
    return await ProfileIconManager.getSelectedIcon();
  }

  Future<void> _getSettingData() async {
    try {
      final parentId = await StorageUtils.getInt('parentId') ?? 0;
      final childrenId = await StorageUtils.getInt('childrenId') ?? 0;

      context.read<SettingBloc>().add(
          SettingProfileRequested(parentId: parentId, childrenId: childrenId));
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
          // Fondo decorativo animado
          Positioned(
            top: 0,
            child: FadeInDown(
              duration: const Duration(milliseconds: 800),
              child: Image.asset(
                'assets/images/topTitleAccount.png',
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Título con animación
                FadeInRight(
                  duration: const Duration(milliseconds: 600),
                  child: const TopTitleGeneric(
                    title: "Ajustes",
                  ),
                ),

                const SizedBox(height: 25),

                // Tarjeta principal con animación
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      color: AppColors.cardBackgroundSoft,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                // Sección de perfil con animación escalonada
                                FadeInLeft(
                                  duration: const Duration(milliseconds: 800),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FutureBuilder<String>(
                                        future: _loadProfileIcon(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Container(
                                              width: 80,
                                              height: 80,
                                              alignment: Alignment.center,
                                              child:
                                                  const CircularProgressIndicator(),
                                            );
                                          }
                                          return Image.asset(
                                            snapshot.data ??
                                                "assets/images/dogJake.png",
                                            width: 80,
                                            height: 80,
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 40),
                                      BlocBuilder<SettingBloc, SettingState>(
                                        builder: (context, state) {
                                          if (state is SettingProfileSuccess) {
                                            final profile =
                                                state.detailsProfileDto;
                                            return ElasticIn(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    profile.parentName,
                                                    style: const TextStyle(
                                                      color: AppColors
                                                          .chocolateNewDark,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Text(
                                                    profile.email,
                                                    style: const TextStyle(
                                                      color: AppColors
                                                          .chocolateNewDark,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else if (state is SettingLoading) {
                                            return const CircularProgressIndicator();
                                          }
                                          return const Text(
                                              "Sin datos de perfil.");
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                FadeInRight(
                                  child: LinearElement(size: size),
                                ),

                                // Opciones de ajustes con animaciones escalonadas
                                FadeInLeft(
                                  duration: const Duration(milliseconds: 600),
                                  child: ItemSetting(
                                    title: "Editar Perfil",
                                    onTap: () {
                                      final state =
                                          context.read<SettingBloc>().state;
                                      if (state is SettingProfileSuccess) {
                                        final profile = state.detailsProfileDto;
                                        context.pushNamed('profileDetails',
                                            extra: profile);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Perfil no disponible.')),
                                        );
                                      }
                                    },
                                  ),
                                ),

                                FadeInRight(
                                  duration: const Duration(milliseconds: 700),
                                  child: ItemSetting(
                                    title: "Cambiar Pin Padres",
                                    onTap: () => context.pushNamed('updatePin'),
                                  ),
                                ),

                                FadeInUp(
                                  duration: const Duration(milliseconds: 800),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.pushReplacement(
                                            '/splash?mode=homeUser');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.chocolateNewDark,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 8.0),
                                        elevation: 4,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            "Modo Niños",
                                            style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/images/kidsButton.png",
                                            width: 40,
                                            height: 40,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                FadeInLeft(
                                  duration: const Duration(milliseconds: 900),
                                  child: LinearElement(size: size),
                                ),

                                FadeInRight(
                                  duration: const Duration(milliseconds: 1000),
                                  child: ItemSetting(
                                    title: "Mas información",
                                    onTap: () =>
                                        context.pushNamed('moreInformation'),
                                  ),
                                ),

                                FadeInLeft(
                                  duration: const Duration(milliseconds: 1100),
                                  child: ItemSetting(
                                    title: "Créditos",
                                    onTap: () =>
                                        context.pushNamed('creditInformation'),
                                  ),
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
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
