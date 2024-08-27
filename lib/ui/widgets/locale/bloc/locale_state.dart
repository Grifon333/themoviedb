part of 'locale_bloc.dart';

final class LocaleState extends Equatable {
  final String localeTag;
  final String countryCode;

  const LocaleState({
    this.localeTag = '',
    this.countryCode = '',
  });

  @override
  List<Object> get props => [localeTag, countryCode];

  LocaleState copyWith({
    String? localeTag,
    String? countryCode,
  }) {
    return LocaleState(
      localeTag: localeTag ?? this.localeTag,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  String toString() {
    return 'LocaleState{localeTag: $localeTag, countryCode: $countryCode}';
  }
}