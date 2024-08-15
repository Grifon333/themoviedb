import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/domain/repositories/auth_repository.dart';
import 'package:themoviedb/ui/widgets/authentication/authentication.dart';

class LoaderWidget extends StatelessWidget {
  final Widget authenticated;
  final Widget unauthenticated;

  const LoaderWidget({
    super.key,
    required this.authenticated,
    required this.unauthenticated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            return authenticated;
          case AuthenticationStatus.unauthenticated:
            return unauthenticated;
          case AuthenticationStatus.unknown:
            return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
