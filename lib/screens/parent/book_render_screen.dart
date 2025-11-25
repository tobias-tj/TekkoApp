import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:tekko/features/api/data/bloc/book/book_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';

class BookRenderScreen extends StatefulWidget {
  final int idBook;
  const BookRenderScreen({super.key, required this.idBook});

  @override
  State<BookRenderScreen> createState() => _BookRenderScreenState();
}

class _BookRenderScreenState extends State<BookRenderScreen> {
  @override
  void initState() {
    super.initState();

    // 🔒 Forzar modo horizontal al entrar
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _getBookPdf();
  }

  @override
  void dispose() {
    // 🔄 Restaurar orientación normal al salir
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  Future<void> _getBookPdf() async {
    try {
      final token = await StorageUtils.getString('token');
      context.read<BookBloc>().add(
            BookPdfRequested(token: token!, bookId: widget.idBook),
          );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is BookLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BookGetPdfSuccess) {
          final file = state.file;

          return ElasticIn(
            duration: const Duration(milliseconds: 500),
            child: PDFView(
              filePath: file.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: true,
              pageSnap: true,
            ),
          );
        }

        if (state is BookError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text("Cargando libro..."));
      },
    );
  }
}
