part of 'locale_bloc.dart';

sealed class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

final class LocaleSetupLocale extends LocaleEvent {
  final String localeTag;
  final String countryCode;

  const LocaleSetupLocale({
    required this.localeTag,
    required this.countryCode,
  });

  @override
  List<Object> get props => [localeTag, countryCode];
}
