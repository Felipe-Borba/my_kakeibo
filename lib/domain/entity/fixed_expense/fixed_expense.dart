import 'package:json_annotation/json_annotation.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';

part 'fixed_expense.g.dart';

@JsonSerializable()
class FixedExpense {
  String? id;
  List<String> expenseIdList;
  DateTime dueDate;
  String description;
  Frequency frequency;
  Remember remember;
  ExpenseCategory category;
  double amount;

  FixedExpense({
    this.id,
    required this.amount,
    required this.expenseIdList,
    required this.dueDate,
    required this.description,
    required this.frequency,
    required this.remember,
    required this.category,
  });

  factory FixedExpense.fromJson(Map<String, dynamic> json) =>
      _$FixedExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$FixedExpenseToJson(this);

  bool get alreadyPaid {
    DateTime now = DateTime.now();
    switch (frequency) {
      case Frequency.daily:
        return dueDate.day != now.day;
      case Frequency.weekly:
        DateTime agora = DateTime.now();
        DateTime primeiroDiaDaSemana = agora.subtract(
          Duration(days: agora.weekday % 7),
        );
        DateTime ultimoDiaDaSemana = primeiroDiaDaSemana.add(
          const Duration(days: 6),
        );
        return dueDate.isAfter(primeiroDiaDaSemana.subtract(
              const Duration(seconds: 1),
            )) &&
            dueDate.isBefore(ultimoDiaDaSemana.add(
              const Duration(days: 1),
            ));
      case Frequency.monthly:
        return dueDate.month != now.month;
      case Frequency.annually:
        return dueDate.year != now.year;
    }
  }

  void pay(Expense expense) {
    if (expense.id != null) {
      expenseIdList.add(expense.id!);
    }
    switch (frequency) {
      case Frequency.daily:
        dueDate = dueDate.add(const Duration(days: 1));
        break;
      case Frequency.weekly:
        dueDate = dueDate.add(const Duration(days: 7));
        break;
      case Frequency.monthly:
        dueDate = _addMonth(dueDate);
        break;
      case Frequency.annually:
        dueDate = _addYear(dueDate);
        break;
    }
  }

  DateTime _addMonth(DateTime data) {
    int novoMes = data.month + 1;
    int novoAno = data.year;

    if (novoMes > 12) {
      novoMes = 1;
      novoAno += 1;
    }

    int ultimoDiaDoMes = DateTime(novoAno, novoMes + 1, 0).day;
    int novoDia = data.day > ultimoDiaDoMes ? ultimoDiaDoMes : data.day;

    return DateTime(novoAno, novoMes, novoDia);
  }

  DateTime _addYear(DateTime data) {
    int novoAno = data.year + 1;

    int ultimoDiaDoMes = DateTime(novoAno, data.month + 1, 0).day;
    int novoDia = data.day > ultimoDiaDoMes ? ultimoDiaDoMes : data.day;

    return DateTime(novoAno, data.month, novoDia);
  }
}

enum Frequency {
  daily,
  weekly,
  monthly,
  annually,
}

enum Remember {
  no,
  weekBefore,
  dayBefore,
  atDueDate,
}
