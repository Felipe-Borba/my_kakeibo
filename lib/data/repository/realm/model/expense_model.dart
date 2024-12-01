import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:realm/realm.dart';

part 'expense_model.realm.dart';

@RealmModel()
class _ExpenseModel {
  @PrimaryKey()
  late String id;
  late double amount;
  late DateTime date;
  late String description;
  late String categoryString;

  ExpenseCategory get category => ExpenseCategory.values
      .firstWhere((e) => e.toString().split('.').last == categoryString);

  set category(ExpenseCategory category) {
    categoryString = category.toString().split('.').last;
  }
}

//TODO ao invés de ter isso espalhado posso fazer um rolezinho com extension lá no enum
//enum ExpenseCategory {
//   misc,
//   rent,
//   food,
//   entertainment,
// }

// extension ExpenseCategoryExtension on ExpenseCategory {
//   // Getter personalizado para obter a descrição
//   String get description {
//     switch (this) {
//       case ExpenseCategory.misc:
//         return "Miscellaneous";
//       case ExpenseCategory.rent:
//         return "Rent";
//       case ExpenseCategory.food:
//         return "Food";
//       case ExpenseCategory.entertainment:
//         return "Entertainment";
//     }
//   }

//   // Método estático para converter string para enum
//   static ExpenseCategory? fromDescription(String description) {
//     switch (description) {
//       case "Miscellaneous":
//         return ExpenseCategory.misc;
//       case "Rent":
//         return ExpenseCategory.rent;
//       case "Food":
//         return ExpenseCategory.food;
//       case "Entertainment":
//         return ExpenseCategory.entertainment;
//       default:
//         return null; // Retorna null se não encontrar correspondência
//     }
//   }
// }
