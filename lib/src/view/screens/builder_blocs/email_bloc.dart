import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/config/themes/app_input_decoration.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/email_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/name_lastname_input.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';

class EmailBloc extends StatelessWidget{

  const EmailBloc({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<ContactCubit, ContactState>(
      buildWhen: (previousState, currentState) => previousState.emailInput != currentState.emailInput,
      builder: (context, state) {
        return TextField(
            key: const Key("contactForm_lastnameInput"),
            onChanged: (value) => context.read<ContactCubit>().emailChanged(value),
            keyboardType: TextInputType.emailAddress,
            decoration: AppInputDecoration.generateISInputDecoration(
                label: "Correo Electrónico",
                hint: "Ingrese su correo electrónico",
                errorMessage: state.emailInput.displayError?.errorMessage
            ),
            style: AppTypography.inputsText,
            enabled: !state.status.isInProgress
        );
      },
    );
  }

}