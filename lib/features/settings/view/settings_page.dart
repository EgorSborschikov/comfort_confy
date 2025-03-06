import 'package:comfort_confy/components/common_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/settings_option.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final int _selectedIndex = 2;
  //final AnalyticsService _analyticsService = AnalyticsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      bottomNavigationBar: CommonBottomNavigationBar(initialIndex: _selectedIndex),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: SettingsOptions(
              context: context,
              onAnalyticsSwitchChanged: (bool value) {
                //_analyticsService.logSwitchEvent('analytics_toggled', {'is_enabled': value});
              },
            ), // Use the new widget here
          ),
        ),
      ),
    );
  }
}
