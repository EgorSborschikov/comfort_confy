import 'package:comfort_confy/mobile/components/conference_start_time_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> createConferencion(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  AppLocalizations.of(context)!.createANewConference,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),
            CupertinoTextField(
              placeholder: AppLocalizations.of(context)!.conferenceName,
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.timeStart,
                ),
                const ConferenceStartTimeChoice()
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.addUsersToTheConference,
                  style: const TextStyle(
                    fontSize: 11.8,
                  ),
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.add_circled, size: 20),
                  color: const Color(0xFF5727EC),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.notifyUsers15MinutesBeforeStartTime,
                ),
                // Замечание: Включите переключатель здесь, если требуется
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.copyLink,
                ),
              ],
            ),
            const SizedBox(height: 25), // Отступ перед кнопкой
            Center( // Центрирование кнопки
              child: CupertinoButton(
                onPressed: () {},
                color: const Color(0xFF5727EC),
                child: Text(
                  AppLocalizations.of(context)!.create,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Отступ после кнопки
          ],
        ),
      );
    },
  );
}