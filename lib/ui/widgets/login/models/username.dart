import 'package:themoviedb/Library/text_form.dart';

enum UsernameValidationError { empty }

class Username extends TextFormInput<String, UsernameValidationError>{
  const Username.pure({String value = ''}) : super.pure(value);
  const Username.dirty({String value = ''}) : super.dirty(value);

  @override
  UsernameValidationError? validator(String value) {
    return (value.isEmpty || value == '') ? UsernameValidationError.empty : null;
  }
}