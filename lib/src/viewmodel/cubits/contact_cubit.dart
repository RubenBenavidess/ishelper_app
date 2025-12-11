import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/city_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/contact_reason_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/country_code_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/country_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/email_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/name_lastname_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/phone_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/requirement_input.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';

/// A [Cubit] that manages the state of a contact form.
///
/// It handles form input changes, validation, and submission.
class ContactCubit extends Cubit<ContactState>{

  /// Creates a new instance of [ContactCubit].
  ContactCubit() : super(ContactState.initial());

  /// Validates the form inputs.
  ///
  /// Takes optional input values to validate. If an input is not provided,
  /// it uses the current value from the state.
  bool _validate({
    NameOrLastNameInput? name,
    NameOrLastNameInput? lastName,
    EmailInput? email,
    PhoneInput? phone,
    CityInput? city,
    CountryInput? country,
    ContactReasonInput? contactReason,
    RequirementInput? requirement,
    CountryCodeInput? code,
  }) {
    return Formz.validate([
      name ?? state.nameInput,
      lastName ?? state.lastNameInput,
      email ?? state.emailInput,
      phone ?? state.phoneInput,
      city ?? state.cityInput,
      country ?? state.countryInput,
      code ?? state.countryCode,
      contactReason ?? state.contactReasonInput,
      requirement ?? state.requirementInput
    ]);
  }

  /// Updates the name input and validates the form.
  void nameChanged(String value){
    final NameOrLastNameInput nameInput = NameOrLastNameInput.dirty(value);
    emit(state.copyWith(
      nameInput: nameInput,
      isValid: _validate(name: nameInput)
    ));
  }

  /// Updates the last name input and validates the form.
  void lastNameChanged(String value){
    final NameOrLastNameInput lastNameInput = NameOrLastNameInput.dirty(value);
    emit(state.copyWith(
      lastNameInput: lastNameInput,
      isValid: _validate(lastName: lastNameInput)
    ));
  }

  /// Updates the email input and validates the form.
  void emailChanged(String value){
    final EmailInput emailInput = EmailInput.dirty(value);
    emit(state.copyWith(
      emailInput: emailInput,
      isValid: _validate(email: emailInput)
    ));
  }

  /// Updates the city input and validates the form.
  void cityChanged(String value){
    final CityInput cityInput = CityInput.dirty(value);
    emit(state.copyWith(
      cityInput: cityInput,
      isValid: _validate(city: cityInput)
    ));
  }

  /// Updates the country input and validates the form.
  void countryChanged(String value){
    final CountryInput countryInput = CountryInput.dirty(value);
    emit(state.copyWith(
      countryInput: countryInput,
      isValid: _validate(country: countryInput)
    ));
  }

  /// Updates the contact reason input and validates the form.
  void contactReasonChanged(String value){
    final ContactReasonInput contactReasonInput = ContactReasonInput.dirty(value);
    emit(state.copyWith(
      contactReasonInput: contactReasonInput,
      isValid: _validate(contactReason: contactReasonInput)
    ));
  }

  /// Updates the country code input and validates the form.
  void countryCodeChanged(String value){
    final CountryCodeInput countryCodeInput = CountryCodeInput.dirty(value);
    emit(state.copyWith(
        countryCode: countryCodeInput,
        isValid: _validate(code: countryCodeInput)
    ));
  }

  /// Updates the phone input and validates the form.
  void phoneChanged(String value){
    final PhoneInput phoneInput = PhoneInput.dirty(value);
    emit(state.copyWith(
        phoneInput: phoneInput,
        isValid: _validate(phone: phoneInput)
    ));
  }

  /// Updates the requirement input and validates the form.
  void requirementChanged(String value){
    final RequirementInput requirementInput = RequirementInput.dirty(value);
    emit(state.copyWith(
        requirementInput: requirementInput,
        isValid: _validate(requirement: requirementInput)
    ));
  }

  // Updates the initial FormzState, must be used CAREFUL.
  void setInitialState(){
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  /// Submits the contact form.
  ///
  /// If the form is not valid or already in progress, it does nothing.
  /// It sets the status to [FormzSubmissionStatus.inProgress] while submitting,
  /// and then to [FormzSubmissionStatus.success] or [FormzSubmissionStatus.failure].
  Future<void> submitContact() async{
    if(!state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.canceled));
      return;
    }
    if(state.status.isInProgress) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      // TODO: Llamada a API de envío de correos.
      // await repository.sendEmail(...);
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      // TODO: Possible error handling.
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

}
