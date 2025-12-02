import 'package:formz/formz.dart';

/// Validation errors for the [CountryInput].
enum CountryInputError {
  /// The input is empty.
  empty,
  /// The input contains invalid characters.
  invalidFormat
}

/// A form input for a country name.
class CountryInput extends FormzInput<String, CountryInputError>
    with FormzInputErrorCacheMixin {
  
  /// Creates a pure [CountryInput] with an empty value.
  CountryInput.pure() : super.pure('');

  /// Creates a dirty [CountryInput] with the given [value].
  CountryInput.dirty([super.value = '']) : super.dirty();

  /// A regular expression to validate a country name.
  ///
  /// Allows alphabetic characters, spaces, hyphens, apostrophes, and dots.
  static final _countryNameRegex = RegExp(r"^[a-zA-ZÀ-ÿ\u00f1\u00d1\s'.-]+$");

  @override
  CountryInputError? validator(String value) {
    final sanitizedValue = value.trim();
    if (sanitizedValue.isEmpty) return CountryInputError.empty;
    if (!_countryNameRegex.hasMatch(sanitizedValue)) {
      return CountryInputError.invalidFormat;
    }

    return null;
  }
}