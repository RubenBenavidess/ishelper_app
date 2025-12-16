import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishelper_app/src/view/utils/pdf_render.dart';
import 'package:ishelper_app/src/viewmodel/cubits/file_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/file_state.dart';

class PDFScreen extends StatelessWidget {

  static const PDFRender pdfRender = PDFRender();

  const PDFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileCubit, FileState>(
      buildWhen: (previous, current) => previous.fileInput != current.fileInput,
      builder: (context, state){
        print(state.fileInput.value.path);
        return pdfRender.renderFile(state.fileInput.value);
      }
    );
  }

}