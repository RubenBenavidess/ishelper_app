import 'package:flutter/material.dart';
import 'package:ishelper_app/src/view/utils/file_render.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFRender extends FileRender{

  const PDFRender();

  @override
  Widget renderFile(File pdf) {
    
    if(pdf.fileType != FileType.pdf) return Container();
    return _PDFViewer(path: pdf.path, fileSource: pdf.fileSource);

  }

}

class _PDFViewer extends StatelessWidget{
 
  final String path;
  final FileSource fileSource;

  const _PDFViewer({required this.path, required this.fileSource});

  @override
  Widget build(BuildContext context) {
    if(fileSource == FileSource.network) {
      return PDF(
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
      ).cachedFromUrl(
        path,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      );
    } else if(fileSource == FileSource.local){
      return Container();
    }
    return Container();
  }

}