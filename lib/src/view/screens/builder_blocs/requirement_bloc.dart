import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/config/themes/app_input_decoration.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/requirement_input.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';

class RequirementBloc extends StatelessWidget{

  static const int _maxLines = 3;
  const RequirementBloc({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<ContactCubit, ContactState>(
        buildWhen: (previousState, currentState) => previousState.requirementInput != currentState.requirementInput,
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Requerimiento", style: AppTypography.labelText),
                const SizedBox(height: 8,),
                TextField(
                  key: const Key("contactForm_requirementInput"),
                  onChanged: (value) =>
                      context.read<ContactCubit>().requirementChanged(value),
                  keyboardType: TextInputType.multiline,
                  maxLines: _maxLines,
                  decoration: AppInputDecoration.generateISInputDecoration(
                      hint: "¿Cómo podemos ayudarte?",
                      errorMessage: state.requirementInput.displayError?.errorMessage
                  ),
                  style: AppTypography.inputsText,
                  enabled: !state.status.isInProgress,
                )
              ]
          );
        }
    );
  }

}