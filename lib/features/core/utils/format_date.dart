import 'package:intl/intl.dart';

String formatDateRange(DateTime start, DateTime end) {
  final dateFormat = DateFormat('EEE d MMM', 'es');
  final timeFormat = DateFormat('HH:mm', 'es');

  if (start.day == end.day && start.month == end.month) {
    // Mismo día: "Vie 12 Abr, 14:30 - 18:00"
    return '${dateFormat.format(start)}, ${timeFormat.format(start)} - ${timeFormat.format(end)}';
  } else {
    // Diferente día: "Vie 12 Abr, 14:30 - Sáb 13 Abr, 10:00"
    return '${dateFormat.format(start)}, ${timeFormat.format(start)} - ${dateFormat.format(end)}, ${timeFormat.format(end)}';
  }
}

String formatDatePretty(String dateStr) {
  final inputFormat = DateFormat('dd/MM/yyyy, HH:mm');
  final outputFormat = DateFormat('EEEE d \'de\' MMMM \nHH:mm', 'es_PY');

  try {
    final date = inputFormat.parse(dateStr);
    return outputFormat.format(date);
  } catch (e) {
    return dateStr; // fallback
  }
}

String formatDateTimePretty(DateTime date) {
  final dateFormat =
      DateFormat('EEEE d \'de\' MMMM', 'es'); // ejemplo: Sábado 30 de agosto
  final timeFormat = DateFormat('HH:mm', 'es'); // ejemplo: 09:00
  return '${dateFormat.format(date)} - ${timeFormat.format(date)}';
}
