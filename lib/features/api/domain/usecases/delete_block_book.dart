import 'package:tekko/features/api/domain/repositories/book_repository.dart';

class DeleteBlockBookUsecases {
  final BookRepository bookRepository;

  DeleteBlockBookUsecases({required this.bookRepository});

  Future<bool> call(String token, int bookId) async {
    return await bookRepository.deleteBlockBook(token, bookId);
  }
}
