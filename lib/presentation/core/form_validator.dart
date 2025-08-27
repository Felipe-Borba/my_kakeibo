import 'package:flutter/widgets.dart';

abstract class FormValidator {
  final GlobalKey<FormState> formKey;
  final BuildContext context;

  FormValidator({required this.context}) : formKey = GlobalKey<FormState>();

  bool isValid() => formKey.currentState?.validate() ?? false;

  bool isInvalid() => !isValid();
}
