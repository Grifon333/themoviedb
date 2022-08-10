import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_button_style.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () => print('show up menu'),
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => print('show search menu'),
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
          // _InvalidWidget(),
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

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

class _FormWidget extends StatefulWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  State<_FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  final _controllerUsername = TextEditingController(text: 'admin');
  final _controllerPassword = TextEditingController(text: 'admin');
  Widget _showProblemWidget = Container();

  void _auth() {
    final login = _controllerUsername.text.trim();
    final password = _controllerPassword.text.trim();
    if (login == 'admin' && password == 'admin') {
      print('open next page');
      _showProblemWidget = Container();
      Navigator.pushReplacementNamed(context, '/main_screen');
    } else if (login == 'admin' && password != 'admin') {
      _showProblemWidget = const _ShowProblemWidget(problem: false);
    } else {
      print('show error');
      _showProblemWidget = const _ShowProblemWidget(problem: true);
    }
    setState(() {});
  }

  void _resetPassword() {
    print('reset password');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _showProblemWidget,
        const SizedBox(height: 16),
        const Text(
          'Username',
          style: AppTextStyle.titleOfTextField,
        ),
        TextField(
          decoration: AppButtonStyle.decorationButton,
          controller: _controllerUsername,
        ),
        const SizedBox(height: 16),
        const Text(
          'Password',
          style: AppTextStyle.titleOfTextField,
        ),
        TextField(
          decoration: AppButtonStyle.decorationButton,
          controller: _controllerPassword,
          obscureText: true,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            ElevatedButton(
              onPressed: _auth,
              style: AppButtonStyle.login,
              child: const Text(
                'Login',
                style: AppTextStyle.login,
              ),
            ),
            const SizedBox(width: 30),
            TextButton(
              onPressed: _resetPassword,
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

// class _InvalidWidget extends StatelessWidget {
//   const _InvalidWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColors.mainColor,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 30,
//       ),
//       child: Column(
//         children: const [
//           Text(
//             'Invalid Session',
//             style: TextStyle(
//                 fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
//           ),
//           Text(
//             'We couldn`t validate your login session. You can refresh this '
//             'page and try again.',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           )
//         ],
//       ),
//     );
//   }
// }

class _ShowProblemWidget extends StatelessWidget {
  final bool problem;

  const _ShowProblemWidget({
    Key? key,
    required this.problem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textOfError = problem
        ? ' - We couldn\'t find your username'
        : ' - We couldn\'t validate your information. \n   Want to try again?';

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
            child: Row(
              children: const [
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
                  textOfError,
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
