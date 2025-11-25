part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object?> get props => [];
}

class BookLoading extends BookState {}

class BookLoadingBlock extends BookState {}

class BookInitial extends BookState {}

class BookError extends BookState {
  final String message;

  const BookError({required this.message});

  @override
  List<Object> get props => [message];
}

class BookBlockError extends BookState {
  final String message;

  const BookBlockError({required this.message});

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

class BlockBookSuccess extends BookState {
  final bool isSucess;

  const BlockBookSuccess({required this.isSucess});

  @override
  List<Object?> get props => [isSucess];
}

class DeleteBlockBookSuccess extends BookState {
  final bool isSucess;

  const DeleteBlockBookSuccess({required this.isSucess});

  @override
  List<Object?> get props => [isSucess];
}

class BookKidGetSuccess extends BookState {
  final GetBookKidDto booksList;

  const BookKidGetSuccess({required this.booksList});

  @override
  List<Object?> get props => [booksList];
}
