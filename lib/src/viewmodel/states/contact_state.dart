import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/city_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/contact_reason_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/country_code_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/country_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/email_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/name_lastname_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/phone_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/requirement_input.dart';

/// Represents the state of the contact form.
///
/// This class holds the current state of all form fields, the overall form
/// submission status, and whether the form is valid. It uses [Equatable] to
/// allow for value-based equality.
class ContactState extends Equatable {

  /// The email input model.
  final EmailInput emailInput;
  /// The name input model.
  final NameOrLastNameInput nameInput;
  /// The last name input model.
  final NameOrLastNameInput lastNameInput;
  /// The phone number input model.
  final PhoneInput phoneInput;
  /// The city input model.
  final CityInput cityInput;
  /// The country input model.
  final CountryInput countryInput;
  /// The country dialing code input model (e.g., "+593").
  final CountryCodeInput countryCode;
  /// The contact reason.
  final ContactReasonInput contactReasonInput;
  /// The requirement message input model.
  final RequirementInput requirementInput;
  /// The current status of the form submission.
  final FormzSubmissionStatus status;
  /// Indicates if the entire form is valid.
  final bool isValid;

  /// Creates an instance of the contact form state.
  const ContactState({
    required this.emailInput,
    required this.nameInput,
    required this.lastNameInput,
    required this.phoneInput,
    required this.cityInput,
    required this.countryInput,
    required this.contactReasonInput,
    required this.requirementInput,
    required this.status,
    required this.isValid,
    required this.countryCode,
  });

  /// Creates the initial state for the contact form.
  factory ContactState.initial() {
    return ContactState(
      emailInput: EmailInput.pure(),
      nameInput: NameOrLastNameInput.pure(),
      lastNameInput: NameOrLastNameInput.pure(),
      phoneInput: PhoneInput.pure(),
      cityInput: CityInput.pure(),
      countryInput: CountryInput.pure(),
      contactReasonInput: ContactReasonInput.pure(),
      requirementInput: RequirementInput.pure(),
      status: FormzSubmissionStatus.initial,
      isValid: false,
      countryCode: CountryCodeInput.pure()
    );
  }

  /// Creates a copy of the current state with the given fields replaced.
  ContactState copyWith({
    EmailInput? emailInput,
    NameOrLastNameInput? nameInput,
    NameOrLastNameInput? lastNameInput,
    PhoneInput? phoneInput,
    CityInput? cityInput,
    CountryInput? countryInput,
    ContactReasonInput? contactReasonInput,
    RequirementInput? requirementInput,
    FormzSubmissionStatus? status,
    bool? isValid,
    CountryCodeInput? countryCode,
  }) {
    return ContactState(
      emailInput: emailInput ?? this.emailInput,
      nameInput: nameInput ?? this.nameInput,
      lastNameInput: lastNameInput ?? this.lastNameInput,
      phoneInput: phoneInput ?? this.phoneInput,
      cityInput: cityInput ?? this.cityInput,
      countryInput: countryInput ?? this.countryInput,
      contactReasonInput: contactReasonInput ?? this.contactReasonInput,
      requirementInput: requirementInput ?? this.requirementInput,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object?> get props => [
        emailInput,
        nameInput,
        lastNameInput,
        phoneInput,
        cityInput,
        countryInput,
        countryCode,
        contactReasonInput,
        requirementInput,
        status,
        isValid
  ];
  
}