import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/components/books/book_card.dart';
import 'package:tekko/components/books/book_kid_header.dart';
import 'package:tekko/components/books/filter_niveles_kid.dart';
import 'package:tekko/features/api/data/bloc/book/book_bloc.dart';
import 'package:tekko/features/api/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/features/api/data/models/get_book_kid_dto.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class BooksKidScreen extends StatefulWidget {
  const BooksKidScreen({super.key});

  @override
  State<BooksKidScreen> createState() => _BooksKidScreenState();
}

class _BooksKidScreenState extends State<BooksKidScreen>
    with TickerProviderStateMixin {
  // Estado local
  int selectedLevel = 1;
  int currentPage = 1;
  bool isLoadingMore = false;

  List<BooksKid> paginatedBooks = [];
  bool hasMore = true;

  late final AnimationController sparkleController;

  @override
  void initState() {
    super.initState();
    sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _getExperienceData();
    _fetchPaginatedBooks(reset: true);
  }

  @override
  void dispose() {
    sparkleController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // PAGINACIÓN
  // ---------------------------------------------------------------------------

  Future<void> _fetchPaginatedBooks({bool reset = false}) async {
    final token = await StorageUtils.getString('token');

    if (reset) {
      currentPage = 1;
      paginatedBooks.clear();
      hasMore = true;
    }

    if (!hasMore) return;

    setState(() => isLoadingMore = true);

    context.read<BookBloc>().add(
          BookKidRequested(
            token: token!,
            limit: 3,
            page: currentPage,
            level: selectedLevel,
          ),
        );
  }

  // ---------------------------------------------------------------------------
  // EXPERIENCIA
  // ---------------------------------------------------------------------------

  Future<void> _getExperienceData() async {
    try {
      final token = await StorageUtils.getString('token');
      context.read<ExperienceBloc>().add(FetchExperienceEvent(token!));
    } catch (_) {}
  }

  // ---------------------------------------------------------------------------
  // MODALES
  // ---------------------------------------------------------------------------

  void _showLockedLevelDialog(int requiredLevel) {
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
                  const HugeIcon(
                      icon: HugeIcons.strokeRoundedSquareLockPassword,
                      size: 35,
                      color: Colors.redAccent),
                  const SizedBox(height: 15),
                  Text(
                    "Nivel bloqueado",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolateNewDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Debes alcanzar el Nivel $requiredLevel para desbloquear esta sección.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Entendido"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: MultiBlocListener(
        listeners: [
          // --------------------------- BOOKS --------------------------
          BlocListener<BookBloc, BookState>(
            listener: (context, state) {
              if (state is BookKidGetSuccess) {
                setState(() {
                  hasMore = state.booksList.hasMore;
                  paginatedBooks.addAll(state.booksList.booksListData);
                  isLoadingMore = false;
                });
              }

              if (state is BookError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),

          // --------------------------- EXPERIENCE ---------------------
          BlocListener<ExperienceBloc, ExperienceState>(
            listener: (context, state) {
              if (state is ExperienceError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: _buildContent(context),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // UI PRINCIPAL
  // ---------------------------------------------------------------------------

  Widget _buildContent(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final expState = context.watch<ExperienceBloc>().state;

    int level = 1;
    int exp = 0;
    int nextExp = 1;

    if (expState is ExperienceLoaded) {
      level = expState.experience.level;
      exp = expState.experience.exp;
      nextExp = expState.experience.expNextlevel;
    }

    return Stack(
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
            )),
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),

              BookKidHeader(level: level, sparkleController: sparkleController),

              const SizedBox(height: 30),

              // Filtros de niveles:

              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(5, (i) {
                          final nivel = i + 1;
                          return FilterNivelesKid(
                            label: "Nivel $nivel",
                            nivelFiltro: nivel,
                            currentLevel: level,
                            selectedLevel: selectedLevel,
                            onSelected: () {
                              setState(() {
                                selectedLevel = nivel;
                                _fetchPaginatedBooks(reset: true);
                              });
                            },
                            onLockedTap: () => _showLockedLevelDialog(nivel),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              // ---------------------------------------------------------------------
              // LISTA DE LIBROS PAGINADOS
              // ---------------------------------------------------------------------
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: paginatedBooks.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: BookCard(book: paginatedBooks[index]),
                ),
              ),

              // --------------------------- VER MÁS ---------------------------
              if (hasMore)
                Center(
                  child: ElevatedButton(
                    onPressed: isLoadingMore
                        ? null
                        : () {
                            currentPage++;
                            _fetchPaginatedBooks();
                          },
                    child: isLoadingMore
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Padding(
                            padding: const EdgeInsets.all(18),
                            child: const Text("Ver más"),
                          ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
