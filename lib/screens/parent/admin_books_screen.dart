import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/features/api/data/bloc/book/book_bloc.dart';
import 'package:tekko/features/api/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/features/api/data/models/get_book_dto.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminBooksScreen extends StatefulWidget {
  const AdminBooksScreen({super.key});

  @override
  State<AdminBooksScreen> createState() => _AdminBooksScreenState();
}

class _AdminBooksScreenState extends State<AdminBooksScreen> {
  // Estado local
  int selectedLevel = 1;
  int currentPage = 1;
  bool isLoadingMore = false;

  List<Books> paginatedBooks = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _getExperienceData();
    _fetchPaginatedBooks(reset: true);
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
          BookGetRequested(
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HugeIcon(
                      size: 45,
                      icon: HugeIcons.strokeRoundedAward01,
                      color: AppColors.chocolateNewDark),
                  const SizedBox(height: 15),
                  const Text(
                    "¿Cómo subir de nivel?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolateNewDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Crea tareas para tu hij@. Al completarlas gana experiencia "
                    "y desbloquea libros de mayor nivel.",
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

  void _showVisibilityConfirmDialog(Books book) {
    final isVisible = book.isVisible!;

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
                          onPressed: () {
                            Navigator.pop(context);
                            // context.read<BookBloc>().add(BookToggleVisibility(book.id));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isVisible ? Colors.red : Colors.green,
                          ),
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
                  const Icon(Icons.lock, size: 40, color: Colors.redAccent),
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
                    "Debes alcanzar el Nivel $requiredLevel para desbloquear este filtro.",
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
              if (state is BookGetSuccess) {
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

              Text(
                'Gestión de Libros',
                style: TextStyle(
                  color: AppColors.softCream,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              _buildLevelProgress(level, exp, nextExp),

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
  // PROGRESO DE NIVEL
  // ---------------------------------------------------------------------------

  Widget _buildLevelProgress(int level, int exp, int missingExp) {
    final totalNeeded = exp + missingExp;
    final percent = exp / totalNeeded;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardMaskSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Nivel actual",
                  style: TextStyle(color: AppColors.chocolateNewDark)),
              IconButton(
                icon:
                    Icon(Icons.info_outline, color: AppColors.chocolateNewDark),
                onPressed: _showLevelInfoModal,
              ),
            ],
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: level.toDouble()),
            duration: const Duration(milliseconds: 700),
            builder: (_, value, __) => Text(
              "Nivel ${value.toInt()}",
              style: const TextStyle(
                fontSize: 32,
                color: AppColors.chocolateNewDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: percent),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (_, value, __) => LinearProgressIndicator(
              value: value,
              minHeight: 12,
              color: AppColors.chocolateDark,
              backgroundColor: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),
          Text("$exp / $totalNeeded EXP"),
          Text("Faltan $missingExp EXP para llegar al Nivel ${level + 1}"),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BOOK CARD
  // ---------------------------------------------------------------------------

  Widget _buildBookCard(BuildContext context, Books book) {
    final isVisible = book.isVisible!;

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
                        onTap: () => _showVisibilityConfirmDialog(book),
                        child: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                          color: isVisible ? Colors.green : Colors.red,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    book.descripcion,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.push('/bookRender', extra: book.libroId),
                    icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01,
                        color: AppColors.textColor),
                    label: const Text("Ver Libro",
                        style: TextStyle(color: AppColors.textColor)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.chocolateNewDark,
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
                _fetchPaginatedBooks(reset: true); // recargar lista
              });
            }
          : () {
              _showLockedLevelDialog(nivelFiltro);
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isUnlocked
              ? (isSelected ? AppColors.chocolateNewDark : Colors.white)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUnlocked
                ? (isSelected
                    ? AppColors.chocolateNewDark
                    : Colors.grey.shade400)
                : Colors.grey.shade400,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isUnlocked
                    ? (isSelected ? Colors.white : Colors.grey.shade700)
                    : Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Icono candado si está bloqueado
            if (!isUnlocked) ...[
              const SizedBox(width: 8),
              const Icon(Icons.lock, size: 18, color: Colors.grey),
            ]
          ],
        ),
      ),
    );
  }
}
