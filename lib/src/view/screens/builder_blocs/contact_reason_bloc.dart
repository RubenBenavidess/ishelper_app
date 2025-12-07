import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/contact_reason_input.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';
import 'package:ishelper_app/config/themes/app_input_decoration.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';

class ContactReasonBloc extends StatelessWidget{

  static const List<String> _reasons = [
    "Soporte Técnico Corporativo Bitdefender",
    "Información de Productos Corporativos Bitdefender",
    "Información de Productos para Hogar Bitdefender",
    "¿Cómo ser Distribuidor Bitdefender?"
  ];

  const ContactReasonBloc({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<ContactCubit, ContactState>(
      buildWhen: (previousState, currentState) =>
        previousState.contactReasonInput != currentState.contactReasonInput,
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Motivo de Contacto", style: AppTypography.labelText),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                key: const Key("contactForm_contactReasonInput"),
                items: _reasons.map((option) {
                  return DropdownMenuItem(
                    value: option,
                      child: Text(
                        option,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.inputsText,
                      ),
                  );
                }).toList(),
                isExpanded: true,
                onChanged: (reason) {
                  if(reason != null) context.read<ContactCubit>().contactReasonChanged(reason);
                },
                decoration: AppInputDecoration.generateISInputDecoration(
                  hint: "Selecciona una opción",
                  errorMessage: state.contactReasonInput.displayError?.errorMessage
                ),
                validator: null,
                style: AppTypography.labelText,
              )
            ]
        );
      }
    );
  }
}