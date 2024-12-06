import 'package:comfort_confy/mobile/components/bars/app_bars/general/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/bars/bottom_navigation_bars/general_navigation_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget{
  const ContactsPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(),
      bottomNavigationBar: const GeneralBottomNavigationBar(),
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [   
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.contacts,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}