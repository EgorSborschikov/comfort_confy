import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'config.dart';
import 'l10n/locale_provider.dart';
import 'router/router.dart';
import 'services/user_services.dart/user_service.dart';
import 'themes/theme_provider.dart';
import 'themes/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleProvider localeProvider = LocaleProvider();

  await localeProvider.loadLanguagePreference();

  // Инициализация Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  bool isRegistered = await isUserRegistered();
  bool isLoggedIn = await isUserLoggedIn();

  final appRouter = AppRouter();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: localeProvider),
      ],
      child: /*DevicePreview(
        enabled: true,
        builder: (context) => */ComfortConfyApp(
          appRouter: appRouter,
          initialRoute: isRegistered
              ? (isLoggedIn ? HomeRoute() : LoginRoute())
              : RegisterRoute(),
        ),
      ),
    //),
  );
}

class ComfortConfyApp extends StatefulWidget {
  final AppRouter appRouter;
  final PageRouteInfo initialRoute;

  const ComfortConfyApp({super.key, required this.appRouter, required this.initialRoute});

  @override
  State<ComfortConfyApp> createState() => _ComfortConfyAppState();
}

class _ComfortConfyAppState extends State<ComfortConfyApp> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: widget.appRouter.config(),
      title: 'ComfortConfy',
      theme: themeProvider.isDarkTheme ? darkTheme : lightTheme,
    );
  }
}
