import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/data/models/get_book_dto.dart';
import 'package:tekko/features/api/domain/usecases/get_book_pdf.dart';
import 'package:tekko/features/api/domain/usecases/get_books_info.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBooksInfoUseCases getBookInfo;
  final GetBookPdf getBookFilePdf;

  BookBloc({required this.getBookInfo, required this.getBookFilePdf})
      : super(BookInitial()) {
    on<BookGetRequested>(_onBookGetRequested);
    on<BookPdfRequested>(_onBookPdfGetRequested);
  }

  Future<void> _onBookGetRequested(
      BookGetRequested event, Emitter<BookState> emit) async {
    emit(BookLoading());

    try {
      final result =
          await getBookInfo(event.token, event.level, event.page, event.limit);
      emit(BookGetSuccess(booksList: result));
    } catch (e) {
      emit(BookError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'Failed to load books'));
    }
  }

  Future<void> _onBookPdfGetRequested(
      BookPdfRequested event, Emitter<BookState> emit) async {
    emit(BookLoading());

    try {
      final result = await getBookFilePdf(event.token, event.bookId);

      emit(BookGetPdfSuccess(file: result));
    } catch (e) {
      emit(BookError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'Failed to load books'));
    }
  }
}
