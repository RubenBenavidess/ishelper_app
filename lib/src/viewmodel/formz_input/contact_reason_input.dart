import 'package:formz/formz.dart';

/// Validation errors for the [CityInput].
enum ContactReasonInputError {
  /// The input is empty.
  empty,
  /// The input exceeds the maximum length.
  invalidLength,
  /// The input contains invalid characters.
  invalidFormat
}

extension ContactReasonInputErrorMessage on ContactReasonInputError {
  String get errorMessage {
    switch (this) {
      case ContactReasonInputError.empty:
        return "Campo obligatorio.";
      case ContactReasonInputError.invalidLength:
        return "El campo no puede superar los 100 caracteres.";
      case ContactReasonInputError.invalidFormat:
        return "El campo solo puede contener letras.";
    }
  }
}

/// A form input for a city name.
class ContactReasonInput extends FormzInput<String, ContactReasonInputError>
    with FormzInputErrorCacheMixin {

  static const int _maxLength = 100;

  /// Creates a pure [ContactReasonInput] with an empty value.
  ContactReasonInput.pure() : super.pure('');

  /// Creates a dirty [ContactReasonInput] with the given [value].
  ContactReasonInput.dirty([super.value = '']) : super.dirty();

  /// A regular expression to validate the contact reason input name.
  ///
  /// Allows alphabetic characters.
  static final _plainTextRegex = RegExp(r'^[a-zA-ZÀ-ÿ\u00f1\u00d1\s?¿!¡.,]{1,100}$');

  @override
  ContactReasonInputError? validator(String value) {

    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return ContactReasonInputError.empty;
    if (sanitizedValue.length > _maxLength) return ContactReasonInputError.invalidLength;
    if (!_plainTextRegex.hasMatch(sanitizedValue)) return ContactReasonInputError.invalidFormat;

    return null;
  }
}