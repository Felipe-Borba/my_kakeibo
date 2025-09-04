import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/custom_exception.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';

extension AppExceptionExtension on CustomException {
  String getLocalizedMessage(BuildContext context) {
    return switch (type) {
      ExceptionType.permissionDenied => context.intl.permissionDenied,
      ExceptionType.userNotFound => context.intl.userNotFound,
      ExceptionType.incomeNotFound => context.intl.incomeNotFound,
      ExceptionType.expenseNotFound => context.intl.expenseNotFound,
      ExceptionType.fixedExpenseNotFound => context.intl.fixedExpenseNotFound,
      ExceptionType.unknownError => context.intl.unknownError,
      ExceptionType.incomeSourceNotFound => context.intl.incomeSourceNotFound,
      ExceptionType.expenseCategoryNotFound =>
        context.intl.expenseCategoryNotFound,
      ExceptionType.notificationPermissionNotGranted =>
        context.intl.notificationPermissionNotGranted,
      ExceptionType.notificationDateInPast =>
        context.intl.notificationDateInPast,
    };
  }
}
