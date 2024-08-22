import 'package:themoviedb/Library/text_form.dart';

enum SearchQueryValidationError { specialCharacters }

String specialCharacters = '!@#\$%^&*()_:;[]{}\\|\'"/?,.<>`~';

class SearchQuery extends TextFormInput<String, SearchQueryValidationError> {
  const SearchQuery.pure({String value = ''}) : super.pure(value);

  const SearchQuery.dirty({String value = ''}) : super.dirty(value);

  @override
  bool get isPure => value.isEmpty;

  @override
  SearchQueryValidationError? validator(String value) {
    for (String char in specialCharacters.split('')) {
      if (value.contains(char)) {
        return SearchQueryValidationError.specialCharacters;
      }
    }
    return null;
  }
}
