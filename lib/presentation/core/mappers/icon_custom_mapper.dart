import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';

extension IconCustomMapper on IconCustom {
  IconData toIconData() {
    return switch (this) {
      IconCustom.dog => Icons.pets,
      IconCustom.home => Icons.home,
      IconCustom.book => Icons.menu_book_rounded,
      IconCustom.food => Icons.restaurant,
      IconCustom.rent => Icons.home_work,
      IconCustom.misc => Icons.task_alt_rounded,
      IconCustom.doctor => Icons.medication_liquid_rounded,
      IconCustom.entertainment => Icons.theater_comedy_rounded,
      IconCustom.salary => Icons.monetization_on_rounded,
      IconCustom.groceries => Icons.shopping_cart,
      IconCustom.transport => Icons.directions_bus,
      IconCustom.gift => Icons.card_giftcard,
      IconCustom.education => Icons.school,
      IconCustom.travel => Icons.flight,
      IconCustom.shopping => Icons.shopping_bag,
      IconCustom.health => Icons.local_hospital,
      IconCustom.sports => Icons.sports_soccer,
      IconCustom.beauty => Icons.brush,
      IconCustom.utilities => Icons.lightbulb,
      IconCustom.taxes => Icons.receipt_long,
      IconCustom.childcare => Icons.child_care,
      IconCustom.alcohol => Icons.local_bar,
      IconCustom.coffee => Icons.local_cafe,
      IconCustom.subscription => Icons.subscriptions,
      IconCustom.charity => Icons.volunteer_activism,
    };
  }

  String getTranslation(BuildContext context) {
    return switch (this) {
      IconCustom.dog => context.intl.dog,
      IconCustom.home => context.intl.home,
      IconCustom.book => context.intl.book,
      IconCustom.food => context.intl.food,
      IconCustom.rent => context.intl.rent,
      IconCustom.misc => context.intl.misc,
      IconCustom.doctor => context.intl.doctor,
      IconCustom.entertainment => context.intl.entertainment,
      IconCustom.salary => context.intl.salary,
      IconCustom.groceries => context.intl.groceries,
      IconCustom.transport => context.intl.transport,
      IconCustom.gift => context.intl.gift,
      IconCustom.education => context.intl.education,
      IconCustom.travel => context.intl.travel,
      IconCustom.shopping => context.intl.shopping,
      IconCustom.health => context.intl.health,
      IconCustom.sports => context.intl.sports,
      IconCustom.beauty => context.intl.beauty,
      IconCustom.utilities => context.intl.utilities,
      IconCustom.taxes => context.intl.taxes,
      IconCustom.childcare => context.intl.childcare,
      IconCustom.alcohol => context.intl.alcohol,
      IconCustom.coffee => context.intl.coffee,
      IconCustom.subscription => context.intl.subscription,
      IconCustom.charity => context.intl.charity,
    };
  }
}
