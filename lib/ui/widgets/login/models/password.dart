import 'package:themoviedb/Library/text_form.dart';

enum PasswordValidationError { empty }

class Password extends TextFormInput<String, PasswordValidationError>{
  const Password.pure({String value = ''}) : super.pure(value);
  const Password.dirty({String value = ''}) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    return value.isEmpty ? PasswordValidationError.empty : null;
  }
}