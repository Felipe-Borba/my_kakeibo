// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Transaction {
  String? id;
  double amount;
  DateTime date;
  String description;
  // TransactionMethod method; TODO meio de pagamento serve para os dois? ou tem um tipo da cada? perguntar pai
  // TransactionRecurrence recurrence;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
  });
}
