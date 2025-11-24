import 'dart:io';
import 'package:tekko/features/api/data/models/get_book_dto.dart';

abstract class BookRepository {
  Future<GetBookDto> getBooksInfo(String token, int level, int page, int limit);
  Future<File> getBookPdf(String token, int bookId);
}
