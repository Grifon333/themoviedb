import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/Library/text_form.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';
import 'package:themoviedb/ui/widgets/login/bloc/login_bloc.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () => debugPrint('show up menu'),
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => debugPrint('show search menu'),
            icon: const Icon(
              Icons.search,
              color: AppColors.lightBlue,
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'TheMovieDB',
        ),
      ),
      body: ListView(
        children: const [
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Login to your account',
            style: AppTextStyle.title,
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text:
                  'In order to use the edit and rating capabilities of TMDB, as '
                  'well as get personal recommendations you will need to login '
                  'to your account. If you do not have an account, registering for '
                  'an account is free and simple. ',
              style: AppTextStyle.mainText,
              children: [
                TextSpan(
                  text: 'Click here',
                  style: AppTextStyle.linkText,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(
                  text: ' to get started.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              text:
                  'If you signed up but didn\'t get your verification email, ',
              style: AppTextStyle.mainText,
              children: [
                TextSpan(
                  text: 'click here',
                  style: AppTextStyle.linkText,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' to have it resent.')
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _FormWidget(),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
      border: OutlineInputBorder(),
      // enabledBorder: OutlineInputBorder(
      //   borderSide: BorderSide(
      //     color: AppColors.enableBorder,
      //     width: 1.0,
      //   ),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderSide: BorderSide(
      //     color: AppColors.focusedBorder,
      //     width: 1.0,
      //   ),
      // ),
      // errorBorder: OutlineInputBorder(
      //   borderSide: BorderSide(
      //     color: AppColors.error,
      //     width: 1.0,
      //   ),
      // ),
      isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ShowErrorWidget(),
        const SizedBox(height: 16),
        const _UsernameWidget(decoration: decoration),
        const SizedBox(height: 16),
        const _PasswordWidget(decoration: decoration),
        const SizedBox(height: 30),
        Row(
          children: [
            const _LoginButtonWidget(),
            const SizedBox(width: 30),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Reset password',
                style: AppTextStyle.resetPassword,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _UsernameWidget extends StatelessWidget {
  final InputDecoration decoration;

  const _UsernameWidget({required this.decoration});

  @override
  Widget build(BuildContext context) {
    final model = context.read<LoginBloc>();
    final displayError = context.select(
              (LoginBloc bloc) => bloc.state.username.displayError,
            ) !=
            null
        ? 'invalid username'
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username',
          style: AppTextStyle.titleOfTextField,
        ),
        TextField(
          decoration: decoration.copyWith(errorText: displayError),
          onChanged: (username) => model.add(
            LoginUsernameChangedEvent(username),
          ),
        ),
      ],
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  final InputDecoration decoration;

  const _PasswordWidget({required this.decoration});

  @override
  Widget build(BuildContext context) {
    final model = context.read<LoginBloc>();
    final displayError = context.select(
              (LoginBloc bloc) => bloc.state.password.displayError,
            ) !=
            null
        ? 'invalid password'
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: AppTextStyle.titleOfTextField,
        ),
        TextField(
          decoration: decoration.copyWith(errorText: displayError),
          onChanged: (password) => model.add(
            LoginPasswordChangedEvent(password),
          ),
          obscureText: true,
        ),
      ],
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget();

  @override
  Widget build(BuildContext context) {
    final isProgress = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgress,
    );
    if (isProgress) return const CircularProgressIndicator();
    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);
    final model = context.read<LoginBloc>();
    final onPressed =
        isValid ? () => model.add(const LoginSubmittedEvent()) : null;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 6,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(AppColors.lightBlue),
      ),
      child: const Text(
        'Login',
        style: AppTextStyle.login,
      ),
    );
  }
}

class _ShowErrorWidget extends StatelessWidget {
  const _ShowErrorWidget();

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((LoginBloc bloc) => bloc.state.error);
    if (errorMessage == null) return const SizedBox.shrink();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'There was a problem',
                  style: AppTextStyle.errorTitle,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
            ),
            child: Row(
              children: [
                Text(
                  ' - $errorMessage',
                  style: AppTextStyle.errorText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
