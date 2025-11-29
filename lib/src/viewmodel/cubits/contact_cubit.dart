import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/city_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/email_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/name_lastname_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/phone_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/requirement_input.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';

class ContactCubit extends Cubit<ContactState>{

  ContactCubit() : super(ContactState.initial());

  List<FormzInput<dynamic, dynamic>> _getInputs({FormzInput? newInput, bool isNameInput = false}){
    
    final List<FormzInput<dynamic, dynamic>> inputsList = []; 

    if(newInput is! NameOrLastNameInput && !isNameInput) inputsList.add(state.nameInput);
    if(newInput is! NameOrLastNameInput && isNameInput) inputsList.add(state.lastNameInput);
    if(newInput is! EmailInput) inputsList.add(state.emailInput);
    if(newInput is! PhoneInput) inputsList.add(state.phoneInput);
    if(newInput is! CityInput) inputsList.add(state.cityInput);
    if(newInput is! RequirementInput) inputsList.add(state.requirementInput);

    return inputsList;

  }

  void nameChanged(String value){
    final NameOrLastNameInput nameInput = NameOrLastNameInput.dirty(value);
    emit(state.copyWith(
      nameInput: nameInput,
      isValid: Formz.validate(
        _getInputs(newInput: nameInput, isNameInput: true)
      )
    ));
  }

}