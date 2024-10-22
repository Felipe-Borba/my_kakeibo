import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

class Expense extends Transaction {
  // TODO depois no futuro seria legal deixar o usuário criar isso
  ExpenseCategory category; //aluguel, conta etc,
  // String payee // quem recebeu
  // PaymentMethod paymentMethod;

  // algumas despesas são dedutíveis como saúde e educação no BR.

  Expense({
    required super.id,
    required super.amount,
    required super.date,
    required super.description,
    required this.category,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json["id"],
      amount: json["amount"],
      date: json["date"],
      description: json["description"],
      category: json["category"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
      'description': description,
      'category': category,
    };
  }

  (bool, AppError) validate() {
    List<FieldError> fieldErrorList = [];
    if (amount <= 0) {
      fieldErrorList.add(
        FieldError("amount", "Amount can't be less than zero"),
      );
    }

    return (
      fieldErrorList.isEmpty,
      fieldErrorList.isEmpty ? Empty() : FieldFailure(fieldErrorList)
    );
  }
}
