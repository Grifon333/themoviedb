import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themoviedb/Library/text_form.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/repositories/auth_repository.dart';
import 'package:themoviedb/ui/widgets/login/models/password.dart';
import 'package:themoviedb/ui/widgets/login/models/username.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChangedEvent>(_onLoginUsernameChanged);
    on<LoginPasswordChangedEvent>(_onLoginPasswordChanged);
    on<LoginSubmittedEvent>(_onLoginSubmitted);
  }

  void _onLoginUsernameChanged(
    LoginUsernameChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(value: event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: TextForm.validate([username, state.password]),
      ),
    );
  }

  void _onLoginPasswordChanged(
    LoginPasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(value: event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: TextForm.validate([state.username, password]),
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: TextFormSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logIn(
        state.username.value,
        state.password.value,
      );
      emit(state.copyWith(status: TextFormSubmissionStatus.success));
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          emit(state.copyWith(
            status: TextFormSubmissionStatus.failure,
            error: 'Server isn\'t available. Check your Internet connection',
          ));
        case ApiClientExceptionType.auth:
          emit(state.copyWith(
            status: TextFormSubmissionStatus.failure,
            error: 'Enter the correct password and/or login',
          ));
        case ApiClientExceptionType.other:
          emit(state.copyWith(
            status: TextFormSubmissionStatus.failure,
            error: 'There was an error. Try again',
          ));
        case ApiClientExceptionType.sessionExpired:
          emit(state.copyWith(
            status: TextFormSubmissionStatus.failure,
            error: 'Try later',
          ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: TextFormSubmissionStatus.failure,
        error: 'Try later',
      ));
    }
  }
}
