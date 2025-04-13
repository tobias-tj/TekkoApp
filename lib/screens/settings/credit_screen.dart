import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tekko/styles/app_colors.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        backgroundColor: AppColors.softCream,
        elevation: 0,
        title: const Text(
          'Créditos y Reconocimientos',
          style: TextStyle(
            color: AppColors.chocolateNewDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.chocolateNewDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: const Text(
                'Agradecimientos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.chocolateNewDark,
                ),
              ),
            ),
            const SizedBox(height: 10),
            FadeInLeft(
              child: const Text(
                'Tekko utiliza los siguientes recursos externos para mejorar la experiencia de usuario:',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),

            // Sección de Iconos
            FadeInRight(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedSmile,
                            color: AppColors.chocolateNewDark,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Paquete de Iconos',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.chocolateNewDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Los iconos utilizados en esta aplicación son cortesía de:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text('Icons8'),
                        subtitle: const Text('https://icons8.com'),
                        onTap: () => _launchURL('https://icons8.com'),
                        trailing: const Icon(Icons.open_in_new),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Todos los derechos de estos iconos pertenecen a sus respectivos creadores en Icons8. '
                        'YvagaCore no reclama propiedad sobre estos recursos gráficos.',
                        style: TextStyle(
                            fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sección de Animaciones
            FadeInLeft(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedMagicWand01,
                            color: AppColors.chocolateNewDark,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Animaciones',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.chocolateNewDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Las animaciones utilizadas en esta aplicación son cortesía de:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text('Lottie'),
                        subtitle: const Text('https://lottiefiles.com'),
                        onTap: () => _launchURL('https://lottiefiles.com'),
                        trailing: const Icon(Icons.open_in_new),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Todas las animaciones son propiedad de sus respectivos creadores. '
                        'YvagaCore simplemente las utiliza bajo las licencias correspondientes.',
                        style: TextStyle(
                            fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sección de Librerías
            FadeInUp(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedLibraries,
                            color: AppColors.chocolateNewDark,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Librerías Utilizadas',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.chocolateNewDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      _buildLibraryItem(
                          'huge_icons', 'Para iconos adicionales'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Nota Legal
            FadeInUp(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Nota: Todos los recursos externos mencionados son utilizados por Tekko '
                  'bajo las respectivas licencias de uso. YvagaCore reconoce y agradece '
                  'el trabajo de estos creadores.',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibraryItem(String name, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.arrow_right,
            color: AppColors.chocolateNewDark,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
