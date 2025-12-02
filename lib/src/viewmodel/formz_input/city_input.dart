import 'package:formz/formz.dart';

/// Validation errors for the [CityInput].
enum CityInputError {
  /// The input is empty.
  empty,
  /// The input exceeds the maximum length.
  tooLong,
  /// The input contains invalid characters.
  invalidFormat
}

/// A form input for a city name.
class CityInput extends FormzInput<String, CityInputError> 
    with FormzInputErrorCacheMixin {

  /// Creates a pure [CityInput] with an empty value.
  CityInput.pure() : super.pure('');

  /// Creates a dirty [CityInput] with the given [value].
  CityInput.dirty([super.value = '']) : super.dirty();

  /// A regular expression to validate the city name.
  ///
  /// Allows alphabetic characters, spaces, hyphens, and apostrophes.
  static final _cityRegex = RegExp(r"^[a-zA-ZÀ-ÿ\u00f1\u00d1\s'-]+$");

  @override
  CityInputError? validator(String value) {
    
    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return CityInputError.empty;
    if (sanitizedValue.length > 60) return CityInputError.tooLong;
    if (!_cityRegex.hasMatch(sanitizedValue)) return CityInputError.invalidFormat;

    return null;
  }
}