import 'package:formz/formz.dart';

/// Validation errors for the [EmailInput].
enum EmailInputError {
  /// The input is empty.
  empty,
  /// The input is not a valid email format.
  invalidFormat
}

/// Extension to get the error message for a [EmailInputError].
extension EmailInputErrorMessage on EmailInputError{
  String get errorMessage{
    switch(this){
      case EmailInputError.empty:
        return "Campo obligatorio.";
      case EmailInputError.invalidFormat:
        return "Formato de correo electrónico inválido.";
    }
  }
}

/// A form input for an email address.
class EmailInput extends FormzInput<String, EmailInputError> 
  with FormzInputErrorCacheMixin {

  /// Creates a pure [EmailInput] with an empty value.
  EmailInput.pure() : super.pure('');

  /// Creates a dirty [EmailInput] with the given [value].
  EmailInput.dirty([super.value = '']) : super.dirty();

  /// A regular expression to validate an email address.
  static final _emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  @override
  EmailInputError? validator(String value) {
    
    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return EmailInputError.empty;
    if (!_emailRegex.hasMatch(sanitizedValue)) return EmailInputError.invalidFormat;

    return null;
  }
}