class GetBookDto {
  final List<Books> booksListData;
  final bool hasMore;

  GetBookDto({required this.booksListData, required this.hasMore});
}

class Books {
  final int libroId;
  final int nivelId;
  final String titulo;
  final String descripcion;
  final int totalPaginas;
  final String portada;
  final bool isVisible;

  Books(
      {required this.libroId,
      required this.nivelId,
      required this.titulo,
      required this.descripcion,
      required this.totalPaginas,
      required this.portada,
      required this.isVisible});
}
