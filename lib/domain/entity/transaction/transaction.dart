abstract class Transaction {
  String? id;
  double amount;
  DateTime date;
  String description;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
  });
}
