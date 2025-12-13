import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart';

enum FileInputError {unsupportedFileType, unsupportedSourceType, invalidPathFormat}

class FileInput extends FormzInput<File, FileInputError> 
  with FormzInputErrorCacheMixin{

  FileInput.pure() : super.pure(
    File(
      fileType: FileType.none, 
      fileSource: FileSource.none, 
      path: ''
  ));

  FileInput.dirty([super.value = 
    const File(
      fileType: FileType.none, 
      fileSource: FileSource.none, 
      path: ''
  )]) : super.dirty();

  @override
  FileInputError? validator(File file) {

    if(file.fileType != FileType.doc || file.fileType != FileType.pdf) return FileInputError.unsupportedFileType;
    if(file.fileSource != FileSource.network || file.fileSource != FileSource.local) return FileInputError.unsupportedSourceType;
    
    final filePath = file.path.trim();
    if(filePath.isEmpty) return FileInputError.invalidPathFormat;

    return null;

  }

}