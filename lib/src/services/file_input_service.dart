import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart';

abstract class FileInputService{

  const FileInputService();

  Function load(File file);

  Function upload(File file);

}