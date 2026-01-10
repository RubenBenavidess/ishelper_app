import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/services/file_input_service.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/file_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart';
import 'package:ishelper_app/src/viewmodel/states/file_state.dart';

/// A [Cubit] that manages the state of file uploads and processing.
///
/// [FileCubit] handles:
/// - File selection and validation
/// - File upload management
/// - File processing state tracking
///
/// It uses a [FileInputService] to handle the actual file operations
/// (e.g., uploading, processing) delegating business logic to the service layer.
class FileCubit extends Cubit<FileState>{

  /// The service responsible for file input operations.
  final FileInputService fileInputService; 

  /// Creates a new instance of [FileCubit].
  ///
  /// Requires a [FileInputService] to handle file operations.
  /// Initializes with an empty [FileState].
  FileCubit({required this.fileInputService}) : super(FileState.initial());

  /// Validates the file input.
  ///
  /// Returns `true` if the file is valid, `false` otherwise.
  bool _validate(FileInput? fileInput){
    return Formz.validate([fileInput ?? state.fileInput]);
  }

  /// Updates the file input when a new file is selected.
  ///
  /// Marks the input as [FileInput.dirty] and re-validates the form.
  /// This method should be called whenever the user selects a new file.
  ///
  /// Parameters:
  ///   - [file]: The selected file to set as the current input.
  void fileChanged(File file) {
    final fileInput = FileInput.dirty(file);
    emit(state.copyWith(
        fileInput: fileInput,
        isValid: _validate(fileInput)
    ));
  }

  /// Initiates the file upload process.
  ///
  /// This method is currently a placeholder for implementing the upload logic.
  /// When implemented, it should:
  /// 1. Validate the file input
  /// 2. Set the status to [FormzSubmissionStatus.inProgress]
  /// 3. Call the [fileInputService] to upload the file
  /// 4. Update the status to success or failure based on the result
  ///
  /// Parameters:
  ///   - [file]: The file to upload.
  ///
  /// TODO: Implement full upload logic with proper error handling.
  void uploadFile(File file){
    
    // final fileInput = FileInput.dirty(file);
    // state.copyWith(
    //   fileInput: fileInput,
    //   isValid: _validate(fileInput)
    // );

    // if(!state.isValid) emit(state.copyWith(status: FormzSubmissionStatus.canceled));

    // try{
    //   fileInputService.upload(file);
    //   emit(state.copyWith(status: FormzSubmissionStatus.success));
    // }catch(e){  
    //   emit(state.copyWith(status: FormzSubmissionStatus.failure));
    // }
  }

}