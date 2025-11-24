import 'package:tekko/features/api/data/models/get_book_dto.dart';
import 'package:tekko/features/api/domain/repositories/book_repository.dart';

class GetBooksInfoUseCases {
  final BookRepository repository;

  GetBooksInfoUseCases({required this.repository});

  Future<GetBookDto> call(String token, int level, int page, int limit) async {
    return await repository.getBooksInfo(token, level, page, limit);
  }
}
