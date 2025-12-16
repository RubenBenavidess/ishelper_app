import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/config/widgets/background_video.dart';
import 'package:ishelper_app/config/widgets/designed_button.dart';
import 'package:ishelper_app/src/viewmodel/cubits/navigation_index_cubit.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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

class _InfoCard extends StatelessWidget{

  static const String mainText = "+500 millones";
  static const String mainSubText1 = "de usuarios protegidos";
  static const mainSubText2 = "La solución de ciberseguridad más utilizada en el mundo.";


  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 24),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          const Text(
            mainText,
            style: AppTypography.h1,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          const Text(
            mainSubText1,
            textAlign: TextAlign.center,
            style: AppTypography.h3,
          ),

          const SizedBox(height: 40),

          const Text(
            mainSubText2,
            textAlign: TextAlign.center,
            style: AppTypography.h3,
          ),

          const SizedBox(height: 60),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/logo-bitdefender.webp',
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
              child: DesignedButton(
                label: 'SOLICITA UNA COTIZACIÓN',
                onPressed: (){
                  context.go('/contact');
                },
              )
          ),
        ],
      ),
    );
  }

}