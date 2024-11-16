import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';

class EnergyTab extends StatelessWidget {
  const EnergyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Dimens.medium,
      children: List.generate(
        EnergyType.values.length,
        (index) => GestureDetector(
          onTap: () {
            // setState(() {
            //   selectedIndex = index;
            // });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.large,
              vertical: Dimens.medium,
            ),
            decoration: BoxDecoration(
              color: 1 == index ? Colors.lightBlue : Colors.white,
              borderRadius: BorderRadius.circular(Dimens.large),
              border: Border.all(
                color: 1 == index ? Colors.lightBlue : Colors.grey,
                width: 1.5,
              ),
            ),
            child: Text(
              EnergyType.values[index].getEnergyString,
              style: TextStyle(
                color: 1 == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
