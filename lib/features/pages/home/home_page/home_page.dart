import 'package:comfort_confy/features/widgets/bars/bottom_navigation_bars/view_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../widgets/bars/app_bars/general/view_general_app_bar.dart';
import '../../../widgets/modal_bottom_sheets/create_conference/view_create_conference.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        title: AppLocalizations.of(context)!.home,
      ),
      bottomNavigationBar: GeneralBottomNavigationBar(initialIndex: _selectedIndex,),
      floatingActionButton: SizedBox(
        width: 50.0, // Custom width
        height: 50.0, // Custom height
        child: FloatingActionButton(
          onPressed: () {
            createConferencion(context);
          },
          shape: const CircleBorder(),
          backgroundColor: const Color(0xFF5727EC),
          child: const Icon(
            CupertinoIcons.add_circled,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 35,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [   
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.callHistory,
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