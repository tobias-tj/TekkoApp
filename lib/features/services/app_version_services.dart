import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tekko/features/core/constants/api_constants.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tekko/features/core/network/dio_client.dart';

class AppVersionService {
  final DioClient dioClient;

  AppVersionService({required this.dioClient});

  Future<void> checkAppVersion(BuildContext context) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion =
          "${packageInfo.version}+${packageInfo.buildNumber}";

      final response = await dioClient.dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.versionAppEndpoint}',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final minVersion = data['minVersion'];
        final latestVersion = data['latestVersion'];
        final forceUpdate = data['forceUpdate'] ?? false;

        bool mustForceUpdate = _isVersionLower(currentVersion, minVersion);
        bool hasNewVersion = _isVersionLower(currentVersion, latestVersion);

        // 🔒 Si debe forzarse la actualización:
        if (mustForceUpdate && forceUpdate) {
          _redirectToStore(context);
          return;
        }

        // ⚠️ Si hay una nueva versión, pero no es obligatoria:
        if (hasNewVersion) {
          _showUpdateDialog(
            context,
            forceUpdate: false,
            latestVersion: latestVersion,
          );
        }
      }
    } catch (e, s) {
      debugPrint("❌ Error al verificar la versión: $e\n$s");
    }
  }

  bool _isVersionLower(String current, String target) {
    try {
      final cParts =
          current.replaceAll('+', '.').split('.').map(int.parse).toList();
      final tParts =
          target.replaceAll('+', '.').split('.').map(int.parse).toList();

      for (int i = 0; i < tParts.length; i++) {
        if (cParts[i] < tParts[i]) return true;
        if (cParts[i] > tParts[i]) return false;
      }
    } catch (_) {}
    return false;
  }

  void _showUpdateDialog(
    BuildContext context, {
    required bool forceUpdate,
    required String latestVersion,
  }) {
    // Asegura que el diálogo se muestre después de que el frame esté listo
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool canClose = !forceUpdate; // si es forzoso, no puede cerrar
      await showGeneralDialog(
        context: context,
        barrierDismissible: !forceUpdate,
        barrierLabel: "update_dialog",
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (_, __, ___) {
          return Center(
            child: StatefulBuilder(
              builder: (context, setState) {
                // Inicia un temporizador de 4s para permitir cerrar (solo si no es obligatorio)
                if (!forceUpdate) {
                  Future.delayed(const Duration(seconds: 4), () {
                    if (context.mounted) setState(() => canClose = true);
                  });
                }

                return AnimatedScale(
                  duration: const Duration(milliseconds: 350),
                  scale: 1.0,
                  curve: Curves.easeOutBack,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/images/shibaIcon.png",
                            width: 70, height: 70),
                        const SizedBox(height: 16),
                        const Text(
                          'Nueva versión disponible',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.chocolateNewDark,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Hay una nueva versión disponible ($latestVersion).\n\n'
                          '${forceUpdate ? "Debes actualizar para continuar." : "Puedes actualizar ahora para obtener las últimas mejoras."}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.chocolateNewDark,
                              height: 1.4,
                              decoration: TextDecoration.none),
                        ),
                        const SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!forceUpdate)
                              ElevatedButton(
                                onPressed: canClose
                                    ? () => Navigator.pop(context)
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Más tarde',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                            if (!forceUpdate) const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () async {
                                final url = Platform.isAndroid
                                    ? 'https://play.google.com/store/apps/details?id=com.yvagacore.tekko'
                                    : 'https://apps.apple.com/app/idXXXXXXXX';
                                final uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri,
                                      mode: LaunchMode.externalApplication);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.chocolateNewDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                              child: const Text(
                                'Actualizar',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        if (!forceUpdate && !canClose)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              'Disponible en 4 segundos...',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    });
  }

  Future<void> _redirectToStore(BuildContext context) async {
    // Esperamos que el árbol de widgets esté listo
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 🔗 URL del store correspondiente
      final url = Platform.isAndroid
          ? 'https://play.google.com/store/apps/details?id=com.yvagacore.tekko'
          : 'https://apps.apple.com/app/idXXXXXXXX';

      final uri = Uri.parse(url);

      // Intenta abrir la tienda
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }

      // 🔄 Cerramos toda la navegación actual
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }

      // 🧹 Limpia la pila de navegación completamente (opcional)
      Future.delayed(const Duration(milliseconds: 500), () {
        exit(
            0); // ❗ Fuerza cierre de la app — el usuario la abrirá desde el store
      });
    });
  }
}
