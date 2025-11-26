import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/features/api/data/bloc/book/book_bloc.dart';
import 'package:tekko/features/api/data/models/get_book_dto.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:tekko/utils/ad_helper.dart';
import 'package:tekko/utils/ad_lock.dart';

class BookCardParent extends StatefulWidget {
  final Books book;
  const BookCardParent({super.key, required this.book});

  @override
  State<BookCardParent> createState() => _BookCardParentState();
}

class _BookCardParentState extends State<BookCardParent> {
  InterstitialAd? _interstitialAd;
  bool isOpening = false;
  bool isToggling = false;

  // ---------------------------------------------------------------
  //                      ACCIÓN: VER LIBRO
  // ---------------------------------------------------------------
  void _onViewBook() {
    if (isOpening) return;
    if (AdLock.isShowingAd) return; // ⛔ Previene abrir otros libros

    setState(() => isOpening = true);
    AdLock.isShowingAd = true; // 🔐 BLOQUEO GLOBAL

    _loadAndShowInterstitial(() {
      setState(() => isOpening = false);
      AdLock.isShowingAd = false; // 🔓 DESBLOQUEO GLOBAL

      context.push('/bookRender', extra: widget.book.libroId);
    });
  }

  void _loadAndShowInterstitial(Function afterAd) {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.setImmersiveMode(true);

          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              AdLock.isShowingAd = false; // 🔓
              afterAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              setState(() => isOpening = false);
              ad.dispose();
              afterAd(); // Si falla igual seguimos
            },
          );

          _interstitialAd!.show();
        },
        onAdFailedToLoad: (error) {
          setState(() => isOpening = false);
          AdLock.isShowingAd = false;
          afterAd();
        },
      ),
    );
  }

  // ---------------------------------------------------------------
  //         ACCIÓN: MOSTRAR / OCULTAR LIBRO (CON INTERSTITIAL)
  // ---------------------------------------------------------------

  void _loadAdBeforeDialog(Function afterAd) {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.setImmersiveMode(true);

          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              afterAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              afterAd(); // Si falla, igualmente seguimos
            },
          );

          _interstitialAd!.show();
        },
        onAdFailedToLoad: (error) {
          // Si no carga el anuncio igual abrimos el diálogo
          afterAd();
        },
      ),
    );
  }

  void _toggleVisibility() {
    if (AdLock.isShowingAd) return;
    if (isToggling) return;

    setState(() => isToggling = true);
    AdLock.isShowingAd = true;

    _loadAdBeforeDialog(() {
      setState(() => isToggling = false);
      AdLock.isShowingAd = false;

      _showVisibilityConfirmDialog(widget.book);
    });
  }

  // ---------------------------------------------------------------
  //                        DIALOG DE CONFIRMACIÓN
  // ---------------------------------------------------------------
  void _showVisibilityConfirmDialog(Books book) {
    final isVisible = book.isVisible;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: FadeInDown(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                    size: 45,
                    color: AppColors.chocolateNewDark,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    isVisible ? "¿Ocultar libro?" : "¿Mostrar libro?",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    isVisible
                        ? "Tu hijo dejará de ver este libro."
                        : "Tu hijo podrá ver este libro.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isVisible ? Colors.red : Colors.green,
                          ),
                          onPressed: () async {
                            Navigator.pop(context); // cerrar dialog

                            final token = await StorageUtils.getString('token');

                            // → MOSTRAR ANUNCIO ANTES DE LA ACCIÓN

                            if (isVisible) {
                              context.read<BookBloc>().add(
                                    CreateBlockBookRequested(
                                      token: token!,
                                      bookId: book.libroId,
                                    ),
                                  );
                            } else {
                              context.read<BookBloc>().add(
                                    DeleteBlockBookRequested(
                                      token: token!,
                                      bookId: book.libroId,
                                    ),
                                  );
                            }
                          },
                          child: Text(
                            isVisible ? "Ocultar" : "Mostrar",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------
  //                            UI
  // ---------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final isVisible = book.isVisible;

    return Card(
      elevation: 5,
      color: AppColors.cardBackgroundSoft,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                book.portada,
                width: 90,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/images/iconTitleDog.png',
                  width: 90,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          book.titulo,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: isToggling ? null : _toggleVisibility,
                        child: isToggling
                            ? SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: isVisible ? Colors.green : Colors.red,
                                ),
                              )
                            : Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: isVisible ? Colors.green : Colors.red,
                                size: 24,
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    book.descripcion,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: isOpening ? null : _onViewBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.chocolateNewDark,
                    ),
                    child: isOpening
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Abriendo libro...",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedArrowRight01,
                                color: AppColors.textColor,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Ver Libro",
                                style: TextStyle(color: AppColors.textColor),
                              ),
                            ],
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
