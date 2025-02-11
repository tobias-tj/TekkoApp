import 'package:flutter/material.dart';
import 'package:tekko/components/dialog_home.dart';
import 'package:tekko/components/profile_icon_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              height: size.height * 0.2, // Altura del fondo
              color: AppColors.chocolateNewDark, // Color del fondo
            ),
          ),

          // Contenido (izquierda, centro, derecha)
          Positioned(
            top: 50, // Espacio desde la parte superior
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Distribuye el espacio
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Izquierda: Fondo circular con un icono
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
                            Text(
                              'Icono',
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    child: Image.asset(_selectedIcon,
                        fit: BoxFit.fill, width: 45, height: 45),
                  ),
                ),

                // Centro: "Nivel 1", barra de progreso y "Nivel De Progreso"
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Nivel 1",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.softCreamDark,
                      ),
                    ),
                    const SizedBox(height: 8), // Espaciado
                    Container(
                      width: 150, // Ancho de la barra de progreso
                      height: 10, // Alto de la barra de progreso
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.5, // Progreso actual de la barra
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.chocolateDark,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8), // Espaciado
                    const Text(
                      "Nivel De Progreso",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.softCreamDark,
                      ),
                    ),
                  ],
                ),

                // Derecha: Icono de estrella y "30XP"
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/iconStar.png',
                          width: 38, height: 30, fit: BoxFit.cover),
                      const SizedBox(height: 4), // Espaciado
                      const Text(
                        "30XP",
                        style: TextStyle(
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

          // DialogHome (se mantiene en su posición original)
          const Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: DialogHome(),
          ),
        ],
      ),
    );
  }
}
