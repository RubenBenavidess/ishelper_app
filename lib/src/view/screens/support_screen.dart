import 'package:flutter/material.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/config/widgets/designed_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  static const String _supportUrl = "https://support.bitdefenderecuador.com.ec/portal/es/newticket?departmentId=570205000000006907&layoutId=570205000000074011";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
                color: AppColors.tertiaryBgColor
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.support_agent_rounded,
                  size: 80,
                  color: Colors.white,
                ),

                const SizedBox(height: 24),

                const Text(
                  "Portal de Soporte",
                  style: AppTypography.h1,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                const Text(
                  "Para brindarte una mejor atención, gestionamos los tickets desde nuestra plataforma segura. Podrás subir archivos, ver el estado de tus casos y chatear con un técnico.",
                  style: AppTypography.h3,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                DesignedButton(
                  label: "ABRIR PORTAL DE SOPORTE",
                  icon: Icons.open_in_new_rounded,
                  onPressed: () => _launchSupportPortal(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchSupportPortal(BuildContext context) async {
    final Uri url = Uri.parse(_supportUrl);

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('No se pudo lanzar $url');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al abrir el soporte: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
