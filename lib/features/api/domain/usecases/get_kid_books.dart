import 'package:tekko/features/api/data/models/get_book_kid_dto.dart';
import 'package:tekko/features/api/domain/repositories/book_repository.dart';

class GetKidBooks {
  final BookRepository repository;

  GetKidBooks({required this.repository});

  Future<GetBookKidDto> call(
      String token, int level, int page, int limit) async {
    return await repository.getKidBooks(token, level, page, limit);
  }
}
