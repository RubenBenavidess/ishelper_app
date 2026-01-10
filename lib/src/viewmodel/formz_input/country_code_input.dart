import 'package:formz/formz.dart';

/// Validation errors for the [CountryCodeInput].
enum CountryCodeInputError {
  /// The input is empty.
  empty,
  /// The input is not a valid country code format (e.g., +1, +44, +593).
  invalidFormat
}

extension CountryCodeInputErrorMessage on CountryCodeInputError{
  String get errorMessage {
    switch(this){
      case CountryCodeInputError.empty:
        return "Campo obligatorio.";
      case CountryCodeInputError.invalidFormat:
        return "Formato de código inválido.";
    }
  }
}

/// A form input for a country dialing code.
class CountryCodeInput extends FormzInput<String, CountryCodeInputError>
    with FormzInputErrorCacheMixin {

  /// Creates a pure [CountryCodeInput] with an empty value.
  CountryCodeInput.pure() : super.pure('');

  /// Creates a dirty [CountryCodeInput] with the given [value].
  CountryCodeInput.dirty([super.value = '']) : super.dirty();

  /// A regular expression to validate a country code.
  static final _countryCodeRegex = RegExp(r'^\d{1,4}$');

  @override
  CountryCodeInputError? validator(String value) {
    final sanitizedValue = value.trim();
    if (sanitizedValue.isEmpty) return CountryCodeInputError.empty;
    if (!_countryCodeRegex.hasMatch(sanitizedValue)) return CountryCodeInputError.invalidFormat;
    return null;
  }
}