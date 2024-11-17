import 'package:energy_consumption/core/extensions/date_formatter.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../bloc/energy_bloc.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateTime.now().getStringUIDate;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 30,
      child: TextField(
        controller: _dateController,
        readOnly: true,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.large),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: Dimens.extraSmall,
            ),
          ),
          labelText: 'Select Date',
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimens.small,
            horizontal: Dimens.medium,
          ),
          suffixIcon: const Icon(
            Icons.calendar_today,
            size: Dimens.large,
            color: Colors.grey,
          ),
        ),
        onTap: () => _selectDate(
          context,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = pickedDate.getStringUIDate;
      });

      sl<EnergyBloc>().add(
        GetEnergyEvent(
          date: pickedDate.getStringDate,
          type: sl<EnergyBloc>().state.selectedType,
        ),
      );
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}