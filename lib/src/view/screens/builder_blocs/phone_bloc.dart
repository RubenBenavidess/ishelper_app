import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';
import 'package:ishelper_app/config/themes/app_input_decoration.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';


class PhoneBloc extends StatelessWidget{

  const PhoneBloc({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<ContactCubit, ContactState>(
      buildWhen: (previousState, currentState) =>
        previousState.countryCode != currentState.countryCode ||
        previousState.phoneInput != currentState.phoneInput,
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Teléfono / Whatsapp", style: AppTypography.labelText),
              const SizedBox(height: 8,),
              IntlPhoneField(
                key: const Key("contactForm_phoneInput"),
                decoration: AppInputDecoration.generateISInputDecoration(
                  hint: "Teléfono",
                ),
                pickerDialogStyle: PickerDialogStyle(
                  backgroundColor: AppColors.primaryBgColor,
                  padding: EdgeInsets.all(24),
                  countryCodeStyle: AppTypography.inputsText
                ),
                initialCountryCode: 'EC',
                languageCode: 'es',

                // ignore: deprecated_member_use
                searchText: "Buscar país",
                disableLengthCheck: true,
                onChanged: (phone) {
                  context.read<ContactCubit>().phoneChanged(phone.number);
                },
                onCountryChanged: (country) {
                  context.read<ContactCubit>().countryCodeChanged(country.dialCode);
                },
                enabled: !state.status.isInProgress,
                validator: (phone){
                  if(phone != null){
                    if(phone.number.isEmpty) return "Campo Obligatorio";
                    try {
                      if (!phone.isValidNumber()) return 'El número de teléfono no es válido';
                    } catch (e) {
                      return 'El número de teléfono no es válido';
                    }
                  }
                  return null;
                },
                style: AppTypography.inputsText,
                dropdownTextStyle: AppTypography.inputsText,
              )

            ]
        );
      },
    );
  }

}