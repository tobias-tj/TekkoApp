import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/components/donation/build_info_item.dart';
import 'package:tekko/features/api/data/bloc/setting/setting_bloc.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:tekko/utils/ad_helper.dart';

class AdminHelpScreen extends StatefulWidget {
  const AdminHelpScreen({super.key});

  @override
  State<AdminHelpScreen> createState() => _AdminHelpScreenState();
}

class _AdminHelpScreenState extends State<AdminHelpScreen> {
  InterstitialAd? _interstitialAd;
  BannerAd? _bannerAd;

  String? userName;

  @override
  void initState() {
    super.initState();

    // Obtener nombre de usuario desde el SettingBloc
    final settingState = context.read<SettingBloc>().state;
    if (settingState is SettingProfileSuccess) {
      userName = settingState.detailsProfileDto.parentName;
    }

    _loadBannerAd();
    _loadInterstitialAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() {}),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Failed to load banner ad: $error');
        },
      ),
    )..load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd?.setImmersiveMode(true);

          _interstitialAd?.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();

              // 🎉 Mostrar SnackBar de agradecimiento
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.emoji_events, color: Colors.yellow),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          userName != null
                              ? "¡Gracias $userName! 🌟 Tekko sigue gratuita gracias a ti."
                              : "¡Gracias! 🌟 Tekko sigue gratuita gracias a tu apoyo.",
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.chocolateNewDark),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: AppColors.textColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 3),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              );

              _loadInterstitialAd(); // recargar para siguiente uso
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Failed to load interstitial ad: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      debugPrint("Interstitial ad not ready yet");
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Stack(
        alignment: Alignment.center,
        children: [
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
                const SizedBox(height: 80),
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  child: SizedBox(
                    height: 200,
                    child: Lottie.asset(
                      "assets/animations/dogHome1.json",
                      repeat: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              "Apoya a Tekko",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.chocolateNewDark,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              userName != null
                                  ? "¡Hola $userName! 🌟 Gracias a tu apoyo, Tekko sigue gratuita. Ver anuncios nos ayuda a apoyar a más familias."
                                  : "¡Gracias por tu apoyo! 🌟 Tekko sigue gratuita. Cada anuncio ayuda a más familias.",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: AppColors.chocolateNewDark,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Column(
                              children: const [
                                BuildInfoItem(
                                  icon: HugeIcons.strokeRoundedSchool,
                                  text:
                                      "Crear herramientas educativas accesibles",
                                ),
                                BuildInfoItem(
                                  icon: HugeIcons.strokeRoundedHealtcare,
                                  text:
                                      "Brindar apoyo a niños y niñas con autismo",
                                ),
                                BuildInfoItem(
                                  icon: HugeIcons.strokeRoundedHeartCheck,
                                  text:
                                      "Mantener la app gratuita para todas las familias",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (_bannerAd != null)
                  Container(
                    alignment: Alignment.center,
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _showInterstitialAd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.chocolateNewDark,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  label: const Text(
                    "Apoya viendo un anuncio 🎬",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
