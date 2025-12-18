import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';


class CountryBloc extends StatelessWidget{

  const CountryBloc({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<ContactCubit, ContactState>(
      buildWhen: (previousState, currentState) =>
        previousState.countryInput != currentState.countryInput ||
        previousState.status != currentState.status,
      builder: (context, state) {
        return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("País:", style: AppTypography.labelText),
              const SizedBox(height: 8,),
              CountryCodePicker(
                key: const Key("contactForm_countryInput"),
                onChanged: (country) => context.read<ContactCubit>().countryChanged(country.name ?? ""),
                onInit: (country){
                  if(country != null) context.read<ContactCubit>().countryChanged(country.name ?? "");
                },
                initialSelection: 'EC',
                favorite: ['+593','EC'],
                showCountryOnly: true,
                showOnlyCountryWhenClosed: true,
                textStyle: AppTypography.labelText,
                boxDecoration: BoxDecoration(
                  color: Colors.white,
                ),
                pickerStyle: PickerStyle.dialog,
                headerText: 'Seleccionar país',
                dialogTextStyle: AppTypography.inputsText,
                headerTextStyle: AppTypography.inputsText,
                searchStyle: AppTypography.inputsText,
                enabled: !state.status.isInProgress,
              ),
            ]
        );
      },
    );
  }

}