part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class AuthenticationLogoutPressedEvent extends AuthenticationEvent {}

final class AuthenticationSubscriptionRequestEvent extends AuthenticationEvent {}