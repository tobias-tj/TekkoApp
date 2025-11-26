import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/features/api/data/models/get_book_kid_dto.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:tekko/utils/kid_read_lok.dart';

class BookCard extends StatefulWidget {
  final BooksKid book;
  const BookCard({super.key, required this.book});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isLoading = false;

  void _openBook() {
    if (isLoading) return; // evita doble click en el mismo card
    if (KidReadLock.isOpeningBook) return; // evita abrir otros libros

    setState(() => isLoading = true);
    KidReadLock.isOpeningBook = true;

    // Navegación
    context.push('/bookRender', extra: widget.book.libroId).whenComplete(() {
      // liberar al volver
      KidReadLock.isOpeningBook = false;
      if (mounted) {
        setState(() => isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

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

                  // BOTÓN
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _openBook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: isLoading
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
                                  "Abriendo...",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedBookOpen02,
                                  color: AppColors.textColor,
                                  size: 28,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Leer",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
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
}
