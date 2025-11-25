import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/data/models/get_book_dto.dart';
import 'package:tekko/features/api/data/models/get_book_kid_dto.dart';
import 'package:tekko/features/api/domain/usecases/create_block_book.dart';
import 'package:tekko/features/api/domain/usecases/delete_block_book.dart';
import 'package:tekko/features/api/domain/usecases/get_book_pdf.dart';
import 'package:tekko/features/api/domain/usecases/get_books_info.dart';
import 'package:tekko/features/api/domain/usecases/get_kid_books.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBooksInfoUseCases getBookInfo;
  final GetBookPdf getBookFilePdf;
  final CreateBlockBookUsecases blockBook;
  final DeleteBlockBookUsecases deleteBlockBook;
  final GetKidBooks getKidBooks;

  BookBloc(
      {required this.getBookInfo,
      required this.getBookFilePdf,
      required this.blockBook,
      required this.deleteBlockBook,
      required this.getKidBooks})
      : super(BookInitial()) {
    on<BookGetRequested>(_onBookGetRequested);
    on<BookPdfRequested>(_onBookPdfGetRequested);
    on<CreateBlockBookRequested>(_onCreateBlockBook);
    on<DeleteBlockBookRequested>(_onDeleteBlockBook);
    on<BookKidRequested>(_onKidBookGetRequested);
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

  Future<void> _onCreateBlockBook(
      CreateBlockBookRequested event, Emitter<BookState> emit) async {
    emit(BookLoadingBlock());

    try {
      final result = await blockBook(event.token, event.bookId);

      emit(BlockBookSuccess(isSucess: result));
    } catch (e) {
      emit(BookBlockError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'Failed to block book'));
    }
  }

  Future<void> _onDeleteBlockBook(
    DeleteBlockBookRequested event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoadingBlock());

    try {
      final result = await deleteBlockBook(event.token, event.bookId);

      emit(DeleteBlockBookSuccess(isSucess: result));
    } catch (e) {
      emit(BookBlockError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'Failed to unblock book'));
    }
  }

  Future<void> _onKidBookGetRequested(
      BookKidRequested event, Emitter<BookState> emit) async {
    emit(BookLoading());

    try {
      final result =
          await getKidBooks(event.token, event.level, event.page, event.limit);
      emit(BookKidGetSuccess(booksList: result));
    } catch (e) {
      emit(BookError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'Failed to load books'));
    }
  }
}
