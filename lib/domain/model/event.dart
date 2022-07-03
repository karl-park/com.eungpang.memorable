class Event {
  Event({
    required this.dateTime,
    required this.title,
    required this.description,
    required this.forWhom,
  });

  final DateTime dateTime;
  final String title;
  final String description;
  final String forWhom;
}

