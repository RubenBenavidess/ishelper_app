import 'package:formz/formz.dart';

/// Validation errors for the [RequirementInput].
enum RequirementInputError {
  /// The input is empty.
  empty,
  /// The input exceeds the maximum length of 500 characters.
  tooLong,
}

/// A form input for a requirement or message field.
class RequirementInput extends FormzInput<String, RequirementInputError>
    with FormzInputErrorCacheMixin {
      
  /// Creates a pure [RequirementInput] with an empty value.
  RequirementInput.pure() : super.pure('');

  /// Creates a dirty [RequirementInput] with the given [value].
  RequirementInput.dirty([super.value = '']) : super.dirty();

  @override
  RequirementInputError? validator(String value) {
    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return RequirementInputError.empty;
    if (sanitizedValue.length > 500) return RequirementInputError.tooLong;

    return null;
  }
}