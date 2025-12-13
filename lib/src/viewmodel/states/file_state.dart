import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/file_input.dart';

class FileState extends Equatable{
  
  final FileInput fileInput;
  final FormzSubmissionStatus status;
  final bool isValid;

  const FileState({
    required this.fileInput, 
    required this.status, 
    required this.isValid  
  });

  factory FileState.initial(){
    return FileState(
      fileInput: FileInput.pure(),
      status: FormzSubmissionStatus.initial,
      isValid: false
    ); 
  }

  FileState copyWith({
      FileInput? fileInput,
      FormzSubmissionStatus? status,
      bool? isValid
    }){
      return FileState(
        fileInput: fileInput ?? this.fileInput, 
        status: status ?? this.status, 
        isValid: isValid ?? this.isValid
      );
  }

  @override
  List<Object?> get props => [
    fileInput,
    status,
    isValid
  ];

}