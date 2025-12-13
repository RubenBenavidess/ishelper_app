import 'package:flutter/material.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart';

abstract class FileRender {

  const FileRender();

  Widget renderFile(File file);

}