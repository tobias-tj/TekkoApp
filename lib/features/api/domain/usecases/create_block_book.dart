import 'package:tekko/features/api/domain/repositories/book_repository.dart';

class CreateBlockBookUsecases {
  final BookRepository bookRepository;

  CreateBlockBookUsecases({required this.bookRepository});

  Future<bool> call(String token, int bookId) async {
    return await bookRepository.createBlockBook(token, bookId);
  }
}
