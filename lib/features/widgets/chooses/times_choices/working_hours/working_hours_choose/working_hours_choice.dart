import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkingHoursChoice extends StatefulWidget {
  const WorkingHoursChoice({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WorkingHoursChoiceState createState() => _WorkingHoursChoiceState();
}

class _WorkingHoursChoiceState extends State<WorkingHoursChoice> {
  TimeOfDay? _openingTime;
  TimeOfDay? _closingTime;

  @override
  void initState() {
    super.initState();
    _loadOpeningHours();
  }

  Future<void> _loadOpeningHours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? openingHour = prefs.getInt('opening_hour');
    int? openingMinute = prefs.getInt('opening_minute');
    int? closingHour = prefs.getInt('closing_hour');
    int? closingMinute = prefs.getInt('closing_minute');

    setState(() {
      _openingTime = openingHour != null && openingMinute != null
          ? TimeOfDay(hour: openingHour, minute: openingMinute)
          : null;
      _closingTime = closingHour != null && closingMinute != null
          ? TimeOfDay(hour: closingHour, minute: closingMinute)
          : null;
    });
  }

  Future<void> _saveOpeningHours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_openingTime != null) {
      await prefs.setInt('opening_hour', _openingTime!.hour);
      await prefs.setInt('opening_minute', _openingTime!.minute);
    }
    if (_closingTime != null) {
      await prefs.setInt('closing_hour', _closingTime!.hour);
      await prefs.setInt('closing_minute', _closingTime!.minute);
    }
  }

  void _selectOpeningTime(BuildContext context) {
    _showTimePicker(context, true);
  }

  void _selectClosingTime(BuildContext context) {
    _showTimePicker(context, false);
  }

  void _showTimePicker(BuildContext context, bool isOpening) async {
    final DateTime now = DateTime.now();
    final TimeOfDay initialTime = isOpening
        ? (_openingTime ?? TimeOfDay.now())
        : (_closingTime ?? TimeOfDay.now());

    final TimeOfDay? picked = await showCupertinoModalPopup<TimeOfDay>(
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(now.year, now.month, now.day,
                initialTime.hour, initialTime.minute),
            onDateTimeChanged: (DateTime newTime) {
              setState(() {
                if (isOpening) {
                  _openingTime = TimeOfDay.fromDateTime(newTime);
                } else {
                  _closingTime = TimeOfDay.fromDateTime(newTime);
                }
                _saveOpeningHours();
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              onPressed: () => _selectOpeningTime(context),
              child: Text(
                AppLocalizations.of(context)!.selectWorkingTime,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(_openingTime != null
                ? _openingTime!.format(context)
                : AppLocalizations.of(context)!.timeStartUpdate),
          ],
        ),
        const SizedBox(height: 1),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              onPressed: () => _selectClosingTime(context),
              child: Text(
                AppLocalizations.of(context)!.selectTimeOff,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(_closingTime != null
                ? _closingTime!.format(context)
                : AppLocalizations.of(context)!.timeEndUpdate),
          ],
        ),
      ],
    );
  }
}
