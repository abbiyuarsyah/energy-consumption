import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/core/extensions/date_formatter.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:energy_consumption/features/energy/presentation/pages/energy_consumption_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/service_locator/service_locator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: tr("energy_app"),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      home: BlocProvider(
        create: (BuildContext context) => sl<EnergyBloc>()
          ..add(GetEnergyEvent(date: DateTime.now().getStringDate)),
        child: OrientationBuilder(builder: (context, orientation) {
          return const EnergyConsumptionPage();
        }),
      ),
    );
  }
}
