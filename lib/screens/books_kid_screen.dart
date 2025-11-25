import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/features/api/data/bloc/book/book_bloc.dart';
import 'package:tekko/features/api/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/features/api/data/models/get_book_dto.dart';
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

  late final AnimationController _sparkleController;

  @override
  void initState() {
    super.initState();
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _getExperienceData();
    _fetchPaginatedBooks(reset: true);
  }

  @override
  void dispose() {
    _sparkleController.dispose();
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

  void _showLevelInfoModal() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: FadeInDown(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundSoft,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HugeIcon(
                    size: 50,
                    icon: HugeIcons.strokeRoundedAward01,
                    color: AppColors.chocolateNewDark,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "¿Cómo subir de nivel?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolateNewDark,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Para subir de nivel, pedile a tus padres que te asignen "
                    "tareas o actividades. Cuando las completes, ganarás puntos "
                    "de experiencia y podrás desbloquear libros nuevos.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.chocolateNewDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "Entendido",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------

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

              _buildHeader(level),

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
                        children: [
                          _buildFilterNiveles('Nivel 1', 1, level),
                          const SizedBox(width: 10),
                          _buildFilterNiveles('Nivel 2', 2, level),
                          const SizedBox(width: 10),
                          _buildFilterNiveles('Nivel 3', 3, level),
                          const SizedBox(width: 10),
                          _buildFilterNiveles('Nivel 4', 4, level),
                          const SizedBox(width: 10),
                          _buildFilterNiveles('Nivel 5', 5, level),
                        ],
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
                  child: _buildBookCard(context, paginatedBooks[index]),
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

  // ---------------------------------------------------------------------------
  // BOOK CARD
  // ---------------------------------------------------------------------------

  Widget _buildBookCard(BuildContext context, BooksKid book) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                book.portada,
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.titulo,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.descripcion,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),

                  // BOTÓN GRANDE
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          context.push('/bookRender', extra: book.libroId),
                      icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedBookOpen02,
                          color: AppColors.textColor,
                          size: 28),
                      label: const Text(
                        "Leer",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterNiveles(String label, int nivelFiltro, int currentLevel) {
    final isUnlocked = currentLevel >= nivelFiltro;
    final isSelected = selectedLevel == nivelFiltro;

    return InkWell(
      onTap: isUnlocked
          ? () {
              setState(() {
                selectedLevel = nivelFiltro;
                _fetchPaginatedBooks(reset: true);
              });
            }
          : () => _showLockedLevelDialog(nivelFiltro),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        margin: const EdgeInsets.only(right: 12, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: !isUnlocked
              ? Colors.grey.shade300
              : isSelected
                  ? AppColors.chocolateNewDark
                  : AppColors.textColor,
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
          ],
        ),
        child: Row(
          children: [
            HugeIcon(
              icon: isUnlocked
                  ? HugeIcons.strokeRoundedStar
                  : HugeIcons.strokeRoundedSquareLockPassword,
              size: 20,
              color: isSelected ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int level) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
      child: Row(
        children: [
          // Sparkly star + title
          ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.05).animate(CurvedAnimation(
              parent: _sparkleController,
              curve: Curves.easeInOut,
            )),
            child: Image.asset(
              "assets/images/activities/readIcon.png",
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Biblioteca',
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Explora cuentos y actividades',
                    style: TextStyle(color: AppColors.softCreamDark)),
              ],
            ),
          ),

          // Level pill
          GestureDetector(
            onTap: _showLevelInfoModal,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: AppColors.chocolateDark.withOpacity(0.95),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(children: [
                Image.asset("assets/images/importantText.png",
                    width: 35, height: 35),
                const SizedBox(width: 8),
                Text('Nivel $level',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
