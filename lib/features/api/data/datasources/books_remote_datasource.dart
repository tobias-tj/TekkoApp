import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tekko/features/api/data/models/get_book_dto.dart';
import 'package:tekko/features/api/data/models/get_book_kid_dto.dart';
import 'package:tekko/features/core/constants/api_constants.dart';

class BooksRemoteDatasource {
  final Dio dio;

  BooksRemoteDatasource({required this.dio});

  Future<GetBookDto> getBooksInfo({
    required String token,
    required int level,
    required int limit,
    required int page,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.getBooksInfoEndpoint,
        queryParameters: {
          'level': level,
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == true) {
        final List<dynamic> list = response.data['data'];
        final pagination = response.data['pagination'];

        final books = list.map((book) {
          return Books(
              libroId: book['libroId'],
              nivelId: book['nivelId'],
              titulo: book['titulo'],
              descripcion: book['descripcion'],
              totalPaginas: book['totalPaginas'],
              portada: book['portada'],
              isVisible: book['isVisible']);
        }).toList();

        return GetBookDto(
          booksListData: books,
          hasMore: pagination['hasMore'],
        );
      } else {
        throw Exception(response.data['message'] ?? 'Error desconocido');
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'No se ha logrado obtener los libros');
    }
  }

  Future<File> getBookPdf({
    required String token,
    required int bookId,
  }) async {
    try {
      final response = await dio.get(
        '/books/$bookId/pdf',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/book_$bookId.pdf');

      await file.writeAsBytes(response.data);

      return file;
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al obtener el PDF del libro');
    }
  }

  Future<bool> createBlockBook(
      {required String token, required int bookId}) async {
    try {
      final response = await dio.post(
        ApiConstants.blockBookEndpoint,
        data: {'bookId': bookId},
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Error al bloquear libro");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Error de red al bloquear libro',
      );
    }
  }

  Future<bool> deleteBlockBook({
    required String token,
    required int bookId,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.deleteBlockEndpoint,
        data: {'bookId': bookId},
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) return true;

      throw Exception("Error al desbloquear libro");
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Error de red al desbloquear libro',
      );
    }
  }

  Future<GetBookKidDto> getKidBooks({
    required String token,
    required int level,
    required int limit,
    required int page,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.getKidBooksEndpoint,
        queryParameters: {
          'level': level,
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == true) {
        final List<dynamic> list = response.data['data'];
        final pagination = response.data['pagination'];

        final books = list.map((book) {
          return BooksKid(
            libroId: book['libroId'],
            nivelId: book['nivelId'],
            titulo: book['titulo'],
            descripcion: book['descripcion'],
            totalPaginas: book['totalPaginas'],
            portada: book['portada'],
          );
        }).toList();

        return GetBookKidDto(
          booksListData: books,
          hasMore: pagination['hasMore'],
        );
      } else {
        throw Exception(response.data['message'] ?? 'Error desconocido');
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'No se ha logrado obtener los libros');
    }
  }
}
