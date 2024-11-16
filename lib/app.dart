import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/service_locator/service_locator.dart';
import 'features/energy/presentation/pages/energy_consumption_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: BlocProvider(
      //   create: (BuildContext context) => sl<EnergyBloc>(),
      //   child: OrientationBuilder(builder: (context, orientation) {
      //     return EnergyConsumptionPage();
      //   }),
      // ),

      home: EnergyConsumptionPage(),
    );
  }
}
