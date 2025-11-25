part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class BookGetRequested extends BookEvent {
  final String token;
  final int level;
  final int page;
  final int limit;

  const BookGetRequested({
    required this.token,
    required this.level,
    required this.page,
    required this.limit,
  });

  @override
  List<Object> get props => [token, level, page, limit];
}

class BookPdfRequested extends BookEvent {
  final String token;
  final int bookId;

  const BookPdfRequested({required this.token, required this.bookId});

  @override
  List<Object> get props => [token, bookId];
}

class CreateBlockBookRequested extends BookEvent {
  final String token;
  final int bookId;

  const CreateBlockBookRequested({required this.token, required this.bookId});

  @override
  List<Object> get props => [token, bookId];
}

class DeleteBlockBookRequested extends BookEvent {
  final String token;
  final int bookId;

  const DeleteBlockBookRequested({required this.token, required this.bookId});

  @override
  List<Object> get props => [token, bookId];
}

class BookKidRequested extends BookEvent {
  final String token;
  final int level;
  final int page;
  final int limit;

  const BookKidRequested({
    required this.token,
    required this.level,
    required this.page,
    required this.limit,
  });

  @override
  List<Object> get props => [token, level, page, limit];
}
