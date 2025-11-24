part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object?> get props => [];
}

class BookLoading extends BookState {}

class BookInitial extends BookState {}

class BookError extends BookState {
  final String message;

  const BookError({required this.message});

  @override
  List<Object> get props => [message];
}

class BookGetSuccess extends BookState {
  final GetBookDto booksList;

  const BookGetSuccess({required this.booksList});

  @override
  List<Object?> get props => [booksList];
}

class BookGetPdfSuccess extends BookState {
  final File file;

  const BookGetPdfSuccess({required this.file});

  @override
  List<Object?> get props => [file];
}
