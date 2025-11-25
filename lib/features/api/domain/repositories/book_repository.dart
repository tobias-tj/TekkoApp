import 'dart:io';
import 'package:tekko/features/api/data/models/get_book_dto.dart';
import 'package:tekko/features/api/data/models/get_book_kid_dto.dart';

abstract class BookRepository {
  Future<GetBookDto> getBooksInfo(String token, int level, int page, int limit);
  Future<File> getBookPdf(String token, int bookId);
  Future<bool> createBlockBook(String token, int bookId);
  Future<bool> deleteBlockBook(String token, int bookId);
  Future<GetBookKidDto> getKidBooks(
      String token, int level, int page, int limit);
}
