part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernameChangedEvent extends LoginEvent {
  final String username;

  const LoginUsernameChangedEvent(this.username);

  @override
  List<Object> get props => [username];
}

final class LoginPasswordChangedEvent extends LoginEvent {
  final String password;

  const LoginPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

final class LoginSubmittedEvent extends LoginEvent {
  const LoginSubmittedEvent();
}
