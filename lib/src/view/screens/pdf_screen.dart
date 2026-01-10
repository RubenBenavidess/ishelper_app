import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';
import 'package:ishelper_app/src/view/utils/pdf_render.dart';
import 'package:ishelper_app/src/viewmodel/cubits/file_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/file_state.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; 
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart' as model;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PDFScreen extends StatelessWidget {

  static const PDFRender pdfRender = PDFRender();

  const PDFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileCubit, FileState>(
      buildWhen: (previous, current) => previous.fileInput != current.fileInput,
      builder: (context, state){

        final model.File currentFile = state.fileInput.value;

        final String fileName = _extractFileName(currentFile.path);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryBgColor,
            title: Text(
              fileName,
              style: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.ios_share),
                onPressed: () => _handleShare(context, currentFile),
              )
            ],
          ),
          body: pdfRender.renderFile(currentFile),
        );
      }
    );
  }

  String _extractFileName(String path) {
    try {
      final uri = Uri.parse(path);
      String name = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'documento.pdf';
      return Uri.decodeComponent(name);
    } catch (e) {
      return 'documento.pdf';
    }
  }

  Future<void> _handleShare(BuildContext context, model.File file) async {

    if (file.fileType != model.FileType.pdf || file.fileSource != model.FileSource.network) return;

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preparando archivo...'),
          duration: Duration(milliseconds: 500),
        ),
      );

      final File cachedFile = await DefaultCacheManager().getSingleFile(file.path);

      final String niceName = _extractFileName(file.path);

      final tempDir = await getTemporaryDirectory();
      final String newPath = '${tempDir.path}/$niceName';

      final File renamedFile = await cachedFile.copy(newPath);

      if (context.mounted) {
        // 3. Compartir
        await Share.shareXFiles(
          [XFile(renamedFile.path)],
          text: 'Te comparto este documento: $niceName',
        );
      }

    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al compartir: $e')),
        );
      }
    }
  }

}

