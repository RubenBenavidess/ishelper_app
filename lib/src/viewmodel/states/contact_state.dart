import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/city_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/email_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/name_lastname_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/phone_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/requirement_input.dart';

/// Represents the state of the contact form logic.
/// 
/// Manages the validation status of each input and the overall form submission status.
class ContactState extends Equatable {

  /// The email input validator.
  final EmailInput emailInput;
  /// The user's name input validator.
  final NameOrLastNameInput nameInput;
  /// The user's last name input validator.
  final NameOrLastNameInput lastNameInput;
  /// The phone number input validator.
  final PhoneInput phoneInput;
  /// The city input validator.
  final CityInput cityInput;
  /// The country name.
  final String countryInput;
  /// The requirement message input validator.
  final RequirementInput requirementInput;
  /// The current status of the form submission (initial, inProgress, success, failure).
  final FormzSubmissionStatus status;
  /// Indicates if the entire form is valid and ready to be submitted.
  final bool isValid;
  /// The country dialing code (e.g., "+593").
  final String countryCode;

  /// Default constructor for the contact state.
  const ContactState({
    required this.emailInput,
    required this.nameInput,
    required this.lastNameInput,
    required this.phoneInput,
    required this.cityInput,
    required this.countryInput,
    required this.requirementInput,
    required this.status,
    required this.isValid,
    required this.countryCode,
  });

  /// Factory constructor: Creates the initial state of the form with pure inputs.
  factory ContactState.initial() {
    return ContactState(
      emailInput: EmailInput.pure(),
      nameInput: NameOrLastNameInput.pure(),
      lastNameInput: NameOrLastNameInput.pure(),
      phoneInput: PhoneInput.pure(),
      cityInput: CityInput.pure(),
      countryInput: 'Sin especificar',
      requirementInput: RequirementInput.pure(),
      status: FormzSubmissionStatus.initial,
      isValid: false,
      countryCode: '+593',
    );
  }

  /// Creates a copy of the current state with optional new values.
  ContactState copyWith({
    EmailInput? emailInput,
    NameOrLastNameInput? nameInput,
    NameOrLastNameInput? lastNameInput,
    PhoneInput? phoneInput,
    CityInput? cityInput,
    String? countryInput,
    RequirementInput? requirementInput,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? countryCode,
  }) {
    return ContactState(
      emailInput: emailInput ?? this.emailInput,
      nameInput: nameInput ?? this.nameInput,
      lastNameInput: lastNameInput ?? this.lastNameInput,
      phoneInput: phoneInput ?? this.phoneInput,
      cityInput: cityInput ?? this.cityInput,
      countryInput: countryInput ?? this.countryInput,
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
        requirementInput,
        status,
        isValid,
        countryCode,
      ];
}