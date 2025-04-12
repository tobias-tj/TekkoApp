import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/screens/settings/profile_summary_screen.dart';
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
      if (state is SettingUpdateProfileSuccess) {
        _getSettingData();
      }
    });
    context.read<SettingBloc>().stream.listen((state) {
      if (state is SettingUpdatePinTokenSuccess) {
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: AppColors.softCream,
            ),
            Column(
              children: [
                TopTitleGeneric(
                  title: "Ajustes",
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                    color: AppColors
                        .cardBackgroundSoft, // Color del card (#C68133)
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16.0), // Bordes redondeados
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Contenedor con borde redondeado y color más oscuro
                        Column(
                          children: [
                            // TextButton(
                            //     onPressed: () => _getSettingData(),
                            //     child:
                            //         Text('Obtener informacion del perfil..')),
                            SizedBox(
                                height:
                                    10), // Texto acompañado de una imagen de volumen
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FutureBuilder<String>(
                                  future: _loadProfileIcon(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // Muestra un ícono de carga mientras se recupera el ícono
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      // Muestra un ícono por defecto si hay un error
                                      return Image.asset(
                                        "assets/images/dogJake.png", // Ruta de un ícono por defecto
                                        width: 80,
                                        height: 80,
                                      );
                                    } else if (snapshot.hasData) {
                                      // Muestra el ícono recuperado
                                      return Image.asset(
                                        snapshot.data!,
                                        width: 80,
                                        height: 80,
                                      );
                                    } else {
                                      // Si no hay datos, muestra un ícono por defecto
                                      return Image.asset(
                                        "assets/images/dogJake.png",
                                        width: 80,
                                        height: 80,
                                      );
                                    }
                                  },
                                ),
                                SizedBox(width: 40),
                                BlocBuilder<SettingBloc, SettingState>(
                                    builder: (context, state) {
                                  if (state is SettingProfileSuccess) {
                                    final profile = state.detailsProfileDto;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          profile.parentName,
                                          style: const TextStyle(
                                            color: AppColors.chocolateNewDark,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          profile.email,
                                          style: const TextStyle(
                                            color: AppColors.chocolateNewDark,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (state is SettingLoading) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    return const Text("Sin datos de perfil.");
                                  }
                                }),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            LinearElement(size: size),
                            ItemSetting(
                              title: "Editar Perfil",
                              onTap: () {
                                final state = context.read<SettingBloc>().state;
                                if (state is SettingProfileSuccess) {
                                  final profile = state.detailsProfileDto;
                                  context.pushNamed('profileDetails',
                                      extra: profile);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Perfil no disponible.')),
                                  );
                                }
                              },
                            ),
                            ItemSetting(
                              title: "Cambiar Pin Padres",
                              onTap: (() => context.pushNamed('updatePin')),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(18),
                              child: ElevatedButton(
                                  onPressed: () {
                                    context.pushReplacement(
                                        '/splash?mode=homeUser');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors
                                        .chocolateNewDark, // Color del botón
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 8.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Modo Niños",
                                        style: const TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Image.asset(
                                          "assets/images/kidsButton.png",
                                          width: 40,
                                          height: 40),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            LinearElement(size: size),
                            ItemSetting(
                              title: "Mas informacion",
                              onTap: () {},
                            ),
                            ItemSetting(
                              title: "Creditos",
                              onTap: () {},
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
