import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreInfoScreen extends StatelessWidget {
  const MoreInfoScreen({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
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
        title: FadeInRight(
          child: const Text(
            'Mas Informacion',
            style: TextStyle(
              color: AppColors.chocolateNewDark,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        leading: IconButton(
          icon: FadeInLeft(
            child: const Icon(Icons.arrow_back,
                color: AppColors.chocolateNewDark, size: 28),
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con logo y título
            FadeInDown(
              child: Container(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.chocolateNewDark,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/iconAppTekko.png',
                      height: 80,
                    ),
                    const SizedBox(width: 180),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Sección Enfoque de Tekko
                  FadeInLeft(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  HugeIcons.strokeRoundedHeartCheck,
                                  color: AppColors.chocolateNewDark,
                                  size: 28,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Nuestro Enfoque',
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
                              'Tekko está especialmente diseñado para niños y niñas con cierto grado de autismo, '
                              'como una herramienta que facilita la comunicación y la realización de actividades '
                              'entre padres e hijos.',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No pretendemos ser psicólogos ni sustituir terapia alguna, sino ser un compañero '
                              'de herramientas que ayude a las familias a entenderse mejor y compartir momentos '
                              'significativos juntos.',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  HugeIcons.strokeRoundedShieldKey,
                                  color: AppColors.chocolateNewDark,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Text(
                                    'Tekko ha sido validado por profesionales de la psicología',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Sección Acerca de YvagaCore
                  FadeInRight(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  HugeIcons.strokeRoundedMore,
                                  color: AppColors.chocolateNewDark,
                                  size: 28,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Acerca de YvagaCore',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.chocolateNewDark,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'YvagaCore es una empresa innovadora dedicada al desarrollo '
                              'de soluciones tecnológicas que mejoran la vida de las familias, '
                              'especialmente aquellas con niños con necesidades especiales.',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () =>
                                  _launchURL('https://www.yvagacore.tech/'),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.link,
                                    color: AppColors.chocolateNewDark,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'www.yvagacore.tech',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Sección Beneficios
                  FadeInLeft(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  HugeIcons.strokeRoundedAgreement01,
                                  color: AppColors.chocolateNewDark,
                                  size: 28,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '¿Cómo ayuda Tekko?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.chocolateNewDark,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            _buildBenefitItem(
                              'Facilita la comunicación visual',
                              HugeIcons.strokeRoundedComment01,
                            ),
                            _buildBenefitItem(
                              'Establece rutinas predecibles',
                              HugeIcons.strokeRoundedCheckList,
                            ),
                            _buildBenefitItem(
                              'Fomenta la independencia',
                              HugeIcons.strokeRoundedChampion,
                            ),
                            _buildBenefitItem(
                              'Refuerza positivamente logros',
                              HugeIcons.strokeRoundedStarCircle,
                            ),
                            _buildBenefitItem(
                              'Crea momentos de conexión familiar',
                              HugeIcons.strokeRoundedUserLove01,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Sección Estado de la App
                  FadeInRight(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  HugeIcons.strokeRoundedInformationCircle,
                                  color: AppColors.chocolateNewDark,
                                  size: 28,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Estado de Tekko',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.chocolateNewDark,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Tekko se encuentra actualmente en fase beta. '
                              'Estamos mejorando constantemente la aplicación '
                              'con retroalimentación de familias y profesionales.',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Agradecemos tu paciencia mientras trabajamos para '
                              'ofrecerte herramientas cada vez más útiles para '
                              'tu familia.',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Sección Donaciones
                  FadeInUp(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: AppColors.chocolateNewDark,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  HugeIcons.strokeRoundedGift,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Apoya este proyecto',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Tekko es una aplicación sin fines de lucro creada '
                              'con mucho amor para ayudar a familias. Tu apoyo '
                              'nos permite seguir desarrollando herramientas útiles.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.chocolateNewDark,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
