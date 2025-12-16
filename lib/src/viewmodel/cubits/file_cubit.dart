import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/services/file_input_service.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/file_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart';
import 'package:ishelper_app/src/viewmodel/states/file_state.dart';

class FileCubit extends Cubit<FileState>{

  final FileInputService fileInputService; 

  FileCubit({required this.fileInputService}) : super(FileState.initial());

  bool _validate(FileInput? fileInput){
    return Formz.validate([fileInput ?? state.fileInput]);
  }

  void fileChanged(File file) {
    final fileInput = FileInput.dirty(file);
    emit(state.copyWith(
        fileInput: fileInput,
        isValid: _validate(fileInput)
    ));
  }

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