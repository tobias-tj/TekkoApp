class GetBookKidDto {
  final List<BooksKid> booksListData;
  final bool hasMore;

  GetBookKidDto({required this.booksListData, required this.hasMore});
}

class BooksKid {
  final int libroId;
  final int nivelId;
  final String titulo;
  final String descripcion;
  final int totalPaginas;
  final String portada;

  BooksKid({
    required this.libroId,
    required this.nivelId,
    required this.titulo,
    required this.descripcion,
    required this.totalPaginas,
    required this.portada,
  });
}
