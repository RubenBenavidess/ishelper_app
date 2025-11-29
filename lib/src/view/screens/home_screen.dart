import 'package:flutter/material.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/config/widgets/background_video.dart';
import 'package:ishelper_app/config/widgets/designed_button.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

class _InfoCard extends StatelessWidget {
  
  static const String _mainText = "+500 millones";
  static const String _mainSubText1 = "de usuarios protegidos";
  static const _mainSubText2 = "La solución de ciberseguridad más utilizada en el mundo.";
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          
           const Text(
            _mainText,
            style: AppTypography.h1,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 8),

          const Text(
            _mainSubText1,
            textAlign: TextAlign.center,
            style: AppTypography.h2,
          ),

          const SizedBox(height: 40),

          const Text(
            _mainSubText2,
            textAlign: TextAlign.center,
            style: AppTypography.h2,
          ),

          const SizedBox(height: 60),

          ClipRRect( // Para redondear la imagen si quieres
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/logo-bitdefender-peq.webp',
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            child: DesignedButton(
              label: 'SOLICITA UNA COTIZACIÓN'
            )
          ),
        ],
      ),
    );
  }
}

class HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        BackgroundVideo(videoPath: "video/main.mp4"),
        Center(
          child: _InfoCard()
        )
      ]
    );
  }

}