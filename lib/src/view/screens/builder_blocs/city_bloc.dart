import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/config/themes/app_input_decoration.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/city_input.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';

class CityBloc extends StatelessWidget{

  const CityBloc({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<ContactCubit, ContactState>(
        buildWhen: (previousState, currentState) =>
          previousState.cityInput != currentState.cityInput,
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                    key: const Key("contactForm_cityInput"),
                    onChanged: (value) =>
                        context.read<ContactCubit>().cityChanged(value),
                    keyboardType: TextInputType.name,
                    decoration: AppInputDecoration.generateISInputDecoration(
                        hint: "Ciudad",
                        errorMessage: state.cityInput.displayError
                            ?.errorMessage
                    ),
                    style: AppTypography.inputsText,
                    enabled: !state.status.isInProgress
                )
              ]
          );
        }
    );
  }

}