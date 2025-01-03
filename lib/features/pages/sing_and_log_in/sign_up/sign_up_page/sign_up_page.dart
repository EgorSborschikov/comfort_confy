import 'dart:developer';

import 'package:comfort_confy/features/pages/sing_and_log_in/login/login_view.dart';
import 'package:comfort_confy/features/widgets/buttons/view_general_button.dart';
import 'package:comfort_confy/features/widgets/text_buttons/view_general_text_button.dart';
import 'package:comfort_confy/services/registration_service/alert_dialog/registration_alert_dialog.dart';
import 'package:comfort_confy/services/registration_service/register_process.dart';
import 'package:comfort_confy/services/registration_service/user_create_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../profile/profile_view.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // ignore: non_constant_identifier_names
  final TextEditingController _nickname_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _password_controller = TextEditingController();

  void _register() async {
    final user = UserCreateModel(
      nickname: _nickname_controller.text,
      email: _email_controller.text,
      password: _password_controller.text,
    );

    try {
      await registerAndSave(user); // Вызов новой функции

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('nickname', user.nickname);
      log('Saved nickname: ${user.nickname}');
      await prefs.setString('email', user.email);
      log('Saved email: ${user.email}');

      // Перенаправление на ProfilePage после успешной регистрации
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => ProfilePage(nickname: user.nickname)),
      );
    } catch (e) {
      print(e); // Обработка ошибок
      registrationAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 110),
                Center(
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(height: 32),
                Text(AppLocalizations.of(context)!.registrationInComfortConfy,
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _nickname_controller,
                  placeholder: AppLocalizations.of(context)!.required,
                  prefix: Text(
                    AppLocalizations.of(context)!.nickname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _email_controller,
                  placeholder: AppLocalizations.of(context)!.required,
                  prefix: Text(
                    AppLocalizations.of(context)!.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _password_controller,
                  placeholder: AppLocalizations.of(context)!.required,
                  prefix: Text(
                    AppLocalizations.of(context)!.password,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                const SizedBox(height: 50),
                GeneralTextButton(
                  text: AppLocalizations.of(context)!.alreadyHaveAnAccountLogin,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin =
                              Offset(1.0, 0.0); // Начальная позиция (справа)
                          const end = Offset.zero; // Конечная позиция (центр)
                          const curve =
                              Curves.linearToEaseOut; // Кривая анимации

                          // Анимация перемещения
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(
                            milliseconds: 600), // Длительность анимации
                      ),
                    );
                  },
                ),
                const SizedBox(height: 80),
                GeneralButton(
                  text: AppLocalizations.of(context)!.register,
                  onTap: _register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
