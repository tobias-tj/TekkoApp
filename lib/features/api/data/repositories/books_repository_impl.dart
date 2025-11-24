import 'package:tekko/features/api/data/datasources/books_remote_datasource.dart';
import 'package:tekko/features/api/data/models/get_book_dto.dart';
import 'package:tekko/features/api/domain/repositories/book_repository.dart';
import 'dart:io';

class BooksRepositoryImpl implements BookRepository {
  final BooksRemoteDatasource remoteDatasource;

  BooksRepositoryImpl({required this.remoteDatasource});

  @override
  Future<GetBookDto> getBooksInfo(
      String token, int level, int page, int limit) async {
    return await remoteDatasource.getBooksInfo(
        token: token, level: level, page: page, limit: limit);
  }

  @override
  Future<File> getBookPdf(String token, int bookId) async {
    return await remoteDatasource.getBookPdf(token: token, bookId: bookId);
  }
}
