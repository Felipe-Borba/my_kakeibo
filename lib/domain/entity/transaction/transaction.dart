abstract class Transaction {
  final String? id;
  final double amount;
  final DateTime date;
  final String description;
  final String? userId;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
    required this.userId,
  });
}
