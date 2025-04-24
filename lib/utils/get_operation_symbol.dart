String getOperationSymbol(String operation) {
  switch (operation) {
    case 'suma':
      return '+';
    case 'resta':
      return '-';
    case 'multiplicacion':
      return '×';
    case 'division':
      return '÷';
    default:
      return '+';
  }
}
