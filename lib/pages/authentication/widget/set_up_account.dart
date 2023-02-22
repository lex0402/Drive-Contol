import 'package:control_car/pages/authentication/authentication_state.dart';
import 'package:control_car/ui/theme.dart';
import 'package:control_car/ui/widgets/textfields/car_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:control_car/utils/images_assets.dart';

class SetUpAccount extends StatelessWidget {
  const SetUpAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context);
    return Container(

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight * 0.6),
            Text(
              'Editer votre compte ',
              style: Theme.of(context).textTheme.headline5,
            ).paddingBottom(CityTheme.elementSpacing / 2),
            Text(
              'Remplissez les informations...',
              style: Theme.of(context).textTheme.bodyText1,
            ).paddingBottom(CityTheme.elementSpacing),
            Row(
              children: [
                Expanded(
                  child: CarTextField(
                    label: 'Prenom',
                    controller: state.firstNameController,
                  ),
                ),
                SizedBox(width: CityTheme.elementSpacing),
                Expanded(
                  child: CarTextField(
                    label: 'Nom',
                    controller: state.lastNameController,
                  ),
                ),
              ],
            ).paddingBottom(CityTheme.elementSpacing),
            CarTextField(
              label: 'Email',
              controller: state.emailController,
            ).paddingBottom(CityTheme.elementSpacing),
            Row(
              children: [
                CupertinoSwitch(
                  value: state.isRoleDriver,
                  onChanged: (v) {
                    state.changeRoleState = v == true ? 1 : 0;
                  },
                ),
                SizedBox(width: CityTheme.elementSpacing * 0.5),
                Text(
                  'I\'m a Driver',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ).paddingBottom(CityTheme.elementSpacing),
            Builder(builder: (context) {
              if (state.isRoleDriver == false) return const SizedBox.shrink();
              return Column(
                children: [
                  CarTextField(
                    label: 'Marque de la voiture',
                    controller: state.vehicleMarqueController,
                  ).paddingBottom(CityTheme.elementSpacing),
                  CarTextField(
                    label: 'Matricule du véhicule',
                    controller: state.vehicleMatriculeController,
                  ).paddingBottom(CityTheme.elementSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: CarTextField(
                          label: 'Code unique ',
                          controller: state.vehicleUnikodeController,
                        ),
                      ),
                      SizedBox(width: CityTheme.elementSpacing),
                      Expanded(
                        child: CarTextField(
                          label: 'License Plate',
                          controller: state.licensePlateController,
                        ),
                      ),
                    ],
                  ).paddingBottom(CityTheme.elementSpacing),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
