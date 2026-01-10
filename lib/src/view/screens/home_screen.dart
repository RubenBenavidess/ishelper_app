import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/config/widgets/background_video.dart';
import 'package:ishelper_app/config/widgets/designed_button.dart';

/// The home screen of the ISHelper application.
///
/// Displays a background video with an information card overlay
/// showcasing the main value proposition of the application.
/// Users can navigate to the contact screen to request a quote.
///
/// This is a [StatefulWidget] to handle video lifecycle management
/// through [initState] and [dispose] methods.
class HomeScreen extends StatefulWidget{

  /// Creates a home screen widget.
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

/// State for the [HomeScreen].
///
/// Manages the lifecycle of the home screen, including
/// video resource initialization and cleanup.
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
        /// Background video layer
        BackgroundVideo(
          videoPath: "assets/video/main.mp4",
          placeholderPath: "assets/images/main_placeholder.jpg",
        ),
        /// Information card overlay
        Center(
          child: _InfoCard()
        )
      ]
    );
  }

}

/// Displays the main information card with company statistics and CTA.
///
/// Shows:
/// - Main statistic: +500 million
/// - Description: Number of protected users
/// - Key message: World's most used cybersecurity solution
/// - Company logo (Bitdefender)
/// - Call-to-action button to request a quote
///
/// This widget is private to the home screen and handles
/// the presentation of the core value proposition.
class _InfoCard extends StatelessWidget{

  /// Main statistic text.
  static const String mainText = "+500 millones";

  /// First subtitle - users protected.
  static const String mainSubText1 = "de usuarios protegidos";

  /// Second subtitle - key message.
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

          /// Bitdefender logo
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/logo-bitdefender.webp',
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 24),

          /// Call-to-action button to request quote
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