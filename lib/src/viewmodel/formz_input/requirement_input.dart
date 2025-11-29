import 'package:formz/formz.dart';

/// RequirementInput errors variants.
enum RequirementInputError {
  /// Empty input.
  empty,
  /// Exceeded defined length (max 500).
  tooLong,
}

/// Class that represents the requirement/message input validator.
class RequirementInput extends FormzInput<String, RequirementInputError> {

  /// Pure constructor: For empty data.
  const RequirementInput.pure() : super.pure('');

  /// Dirty constructor: For filled data.
  const RequirementInput.dirty([super.value = '']) : super.dirty();

  /// Validates the input data.
  ///
  /// [value] is the input data.
  ///
  /// Returns the requirement input error or null (no error).
  @override
  RequirementInputError? validator(String value) {

    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return RequirementInputError.empty;
    if (sanitizedValue.length > 500) return RequirementInputError.tooLong;

    return null;
  }
}