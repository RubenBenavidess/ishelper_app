import 'package:formz/formz.dart';

/// Validation errors for the [NameOrLastNameInput].
enum NameOrLastNameInputError {
  /// The input is empty.
  empty,
  /// The input exceeds the maximum length of 35 characters.
  invalidLength,
  /// The input contains invalid characters.
  invalidFormat
}

/// Extension to get the error message for a [NameOrLastNameInputError].
extension NameOrLastNameInputErrorMessage on NameOrLastNameInputError{
  String get errorMessage {
    switch (this) {
      case NameOrLastNameInputError.empty:
        return "Campo obligatorio.";
      case NameOrLastNameInputError.invalidLength:
        return "Máximo 35 caracteres.";
      case NameOrLastNameInputError.invalidFormat:
        return "Solo letras y caracteres válidos.";
    }
  }
}

/// A form input for a name or last name.
class NameOrLastNameInput extends FormzInput<String, NameOrLastNameInputError>
    with FormzInputErrorCacheMixin {

  static const _maxLength = 35; 

  /// Creates a pure [NameOrLastNameInput] with an empty value.
  NameOrLastNameInput.pure() : super.pure('');

  /// Creates a dirty [NameOrLastNameInput] with the given [value].
  NameOrLastNameInput.dirty([super.value = '']) : super.dirty();

  /// A regular expression to validate a name or last name.
  ///
  /// Allows alphabetic characters, spaces, hyphens, and apostrophes.
  static final _dataRegex = RegExp(r"^[a-zA-ZÀ-ÿ\u00f1\u00d1\s'-]+$");

  @override
  NameOrLastNameInputError? validator(String value) {
    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return NameOrLastNameInputError.empty;
    if (sanitizedValue.length > _maxLength) return NameOrLastNameInputError.invalidLength;
    if (!_dataRegex.hasMatch(sanitizedValue)) return NameOrLastNameInputError.invalidFormat;

    return null;
  }
}