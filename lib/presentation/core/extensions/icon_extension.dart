import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';

extension IconExtension on IconCustom {
  IconData toIconData() {
    return switch (this) {
      IconCustom.dog => Icons.pets,
      IconCustom.home => Icons.home,
      IconCustom.book => Icons.menu_book_rounded,
      IconCustom.food => Icons.restaurant,
      IconCustom.rent => Icons.car_rental,
      IconCustom.misc => Icons.task_alt_rounded,
      IconCustom.doctor => Icons.medication_liquid_rounded,
      IconCustom.entertainment => Icons.theater_comedy_rounded,
      IconCustom.salary => Icons.monetization_on_rounded,
    };
  }
}