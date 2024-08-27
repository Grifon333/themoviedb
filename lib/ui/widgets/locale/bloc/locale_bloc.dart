import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/domain/data_providers/locale_data_provider.dart';

part 'locale_event.dart';

part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final LocaleDataProvider _localeDataProvider;

  LocaleBloc({
    required LocaleDataProvider localeDataProvider,
  })  : _localeDataProvider = localeDataProvider,
        super(const LocaleState()) {
    on<LocaleSetupLocale>(_onSetupLocale);
  }

  Future<void> _onSetupLocale(
    LocaleSetupLocale event,
    Emitter<LocaleState> emit,
  ) async {
    await _localeDataProvider.setLocaleTag(event.localeTag);
    await _localeDataProvider.setCountryCode(event.countryCode);
    emit(state.copyWith(
      localeTag: event.localeTag,
      countryCode: event.countryCode,
    ));
  }
}
