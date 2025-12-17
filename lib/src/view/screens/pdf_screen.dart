import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';
import 'package:ishelper_app/src/view/utils/pdf_render.dart';
import 'package:ishelper_app/src/viewmodel/cubits/file_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/file_state.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; 
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart' as model;
import 'package:share_plus/share_plus.dart';

class PDFScreen extends StatelessWidget {

  static const PDFRender pdfRender = PDFRender();

  const PDFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileCubit, FileState>(
      buildWhen: (previous, current) => previous.fileInput != current.fileInput,
      builder: (context, state){
        final currentFile = state.fileInput.value;

        return Scaffold(
          // 1. APPBAR: Aquí solucionamos la navegación y el título
          appBar: AppBar(
            backgroundColor: AppColors.primaryBgColor, // Tu color corporativo
            title: Text(
              // Usamos el nombre del archivo o un default. 
              // Asegúrate de que tu modelo 'File' tenga una propiedad 'name'
              'Documento PDF', 
              style: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
            ),
            
            // El botón "Atrás" (<) se agrega automáticamente si usamos Navigator.push
            // Pero si quieres personalizarlo:
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).pop(),
            ),

            actions: [
              // 2. BOTÓN DE DESCARGA / COMPARTIR
              IconButton(
                icon: const Icon(Icons.ios_share), // Icono estándar de exportar
                onPressed: () => _handleShare(context, currentFile),
              ),
            ],
          ),
          
          // 3. BODY: Aquí renderizamos tu PDF usando tu clase existente
          body: pdfRender.renderFile(currentFile),
        );
      }
    );
  }

  Future<void> _handleShare(BuildContext context, model.File file) async {
    // Verificamos usando tu modelo
    if (file.fileType != model.FileType.pdf || file.fileSource != model.FileSource.network) {
      return;
    }

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preparando archivo...'),
          duration: Duration(milliseconds: 500),
        ),
      );

      // 1. Recuperamos el archivo FÍSICO del caché
      // Aquí usamos 'File' de dart:io (porque no tiene prefijo)
      final File cachedFile = await DefaultCacheManager().getSingleFile(file.path);

      if (context.mounted) {
        // 2. COMPARTIR (Forma Estándar v10+)
        // Usamos Share.shareXFiles. Si te sale tachado, ignóralo por ahora, 
        // es la implementación más estable para archivos múltiples/cross-platform.
        // El 'SharePlus.instance' es para uso interno de la librería.
        
        await Share.shareXFiles(
          [XFile(cachedFile.path)], // Convertimos File a XFile
          text: 'Aquí tienes el documento',
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

