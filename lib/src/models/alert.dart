class Alert {
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isCritical;

  Alert({
    required this.title,
    required this.description,
    required this.timestamp,
    this.isCritical = false,
  });
}