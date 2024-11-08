import 'package:comfort_confy/l10n/locale_provider.dart';
import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comfort_confy/themes/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/language_drop_down.dart';

class SettingPage extends StatelessWidget{
  const SettingPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(),
      bottomNavigationBar: const GeneralBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.personalization,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.onDarkTheme,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context).isDarkTheme,
                      onChanged: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .ToggleTheme(bool, value); 
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.choiceLanguage,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const LanguageDropDown(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

