import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/config/themes/app_input_decoration.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/name_lastname_input.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';

class NameBloc extends StatelessWidget{

  const NameBloc({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<ContactCubit, ContactState>(
      buildWhen: (previousState, currentState) => previousState.nameInput != currentState.nameInput,
      builder: (context, state) {
        return TextField(
          key: const Key("contactForm_nameInput"),
          onChanged: (value) => context.read<ContactCubit>().nameChanged(value),
          keyboardType: TextInputType.name,
          decoration: AppInputDecoration.generateISInputDecoration(
            label: "Nombre",
            hint: "Ingrese su nombre",
            errorMessage: state.nameInput.displayError?.errorMessage
          ),
          style: AppTypography.inputsText,
          enabled: !state.status.isInProgress
        );
      },
    );
  }

}