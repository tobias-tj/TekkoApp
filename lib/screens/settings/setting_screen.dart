import 'package:flutter/material.dart';
import 'package:tekko/components/linear_element.dart';
import 'package:tekko/components/profile_icon_manager.dart';
import 'package:tekko/components/top_title_generic.dart';
import 'package:tekko/screens/settings/item_setting.dart';
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
  }

  Future<String> _loadProfileIcon() async {
    return await ProfileIconManager.getSelectedIcon();
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
                                Column(
                                  children: [
                                    Text(
                                      "Tobias",
                                      style: const TextStyle(
                                        color: AppColors.chocolateNewDark,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      "Ema1@gmail.com",
                                      style: const TextStyle(
                                        color: AppColors.chocolateNewDark,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            LinearElement(size: size),
                            ItemSetting(
                              title: "Editar Perfil",
                            ),
                            ItemSetting(
                              title: "Cambiar Contraseña",
                            ),
                            ItemSetting(
                              title: "Musica",
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18),
                              child: ElevatedButton(
                                  onPressed: () {
                                    // Lógica para manejar el modo padres
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
                                        "Modo Padres",
                                        style: const TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Image.asset(
                                          "assets/images/parentIcon.png",
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
                            ),
                            ItemSetting(
                              title: "Creditos",
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
