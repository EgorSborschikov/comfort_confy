import 'package:comfort_confy/components/common/common_button.dart';
import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/features/register/view/register_page.dart';
import 'package:comfort_confy/services/supabase_services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/common/common_text_button.dart';
import '../../../components/common/common_text_field.dart';
import '../../home/view/home_page.dart';

class LoginPage extends StatefulWidget {
  
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  
  final authService = AuthServices();

  // ignore: non_constant_identifier_names
  final TextEditingController _email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _password_controller = TextEditingController();

  void _login() async {
    final email = _email_controller.text;
    final password = _password_controller.text;

    if(email != null && password != null) {
      try {
        authService.signInWithEmailPassword(
          email, 
          password
        );
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => HomePage()
          )
        );
      } catch(e) {
        const PlatformWarningElements(
          title: "Error!", 
          content: 'Register process failed. Try again?'
        );
      }
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
                Text(AppLocalizations.of(context)!.logInComfortConfy,
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),
                CommonTextField(
                  controller: _email_controller, 
                  prefix: AppLocalizations.of(context)!.email, 
                  isObscure: false,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                CommonTextField(
                  controller: _password_controller, 
                  prefix: AppLocalizations.of(context)!.password, 
                  isObscure: _isObscure,
                  suffix: IconButton(
                    icon: Icon(
                      _isObscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 80),
                CommonTextButton(
                  text: AppLocalizations.of(context)!.dontHaveAnAccountRegister,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const RegisterPage(),
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
                const SizedBox(height: 100),
                CommonButton(
                  text: AppLocalizations.of(context)!.login,
                  onTap: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}