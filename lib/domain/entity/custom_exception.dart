class CustomException implements Exception {
  final ExceptionType type;

  CustomException(this.type);

  CustomException.permissionDenied() //
      : type = ExceptionType.permissionDenied;
  CustomException.userNotFound() //
      : type = ExceptionType.userNotFound;
  CustomException.incomeNotFound() //
      : type = ExceptionType.incomeNotFound;
  CustomException.incomeSourceNotFound() //
      : type = ExceptionType.incomeSourceNotFound;
  CustomException.expenseNotFound() //
      : type = ExceptionType.expenseNotFound;
  CustomException.expenseCategoryNotFound() //
      : type = ExceptionType.expenseCategoryNotFound;
  CustomException.fixedExpenseNotFound() //
      : type = ExceptionType.fixedExpenseNotFound;
  CustomException.unknownError() //
      : type = ExceptionType.unknownError;
  CustomException.notificationPermissionNotGranted() //
      : type = ExceptionType.notificationPermissionNotGranted;
}

enum ExceptionType {
  permissionDenied,
  notificationPermissionNotGranted,
  userNotFound,
  incomeNotFound,
  incomeSourceNotFound,
  expenseNotFound,
  expenseCategoryNotFound,
  fixedExpenseNotFound,
  unknownError,
}
