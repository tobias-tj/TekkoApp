import 'package:tekko/features/api/domain/repositories/book_repository.dart';
import 'dart:io';

class GetBookPdf {
  final BookRepository repository;

  GetBookPdf({required this.repository});

  Future<File> call(String token, int bookId) async {
    return await repository.getBookPdf(token, bookId);
  }
}
