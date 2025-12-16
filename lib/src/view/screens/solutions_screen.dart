import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/config/widgets/designed_button.dart';
import 'package:ishelper_app/config/widgets/image_carousel.dart';
import 'package:ishelper_app/src/viewmodel/cubits/file_cubit.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart';
import 'package:ishelper_app/src/viewmodel/states/file_state.dart';

class SolutionsScreen extends StatelessWidget{

  const SolutionsScreen({super.key});

  @override
  Widget build(BuildContext context){
    
    const String mainTitle = "Nuestras Soluciones";

    const String description1 = 
    """
    Bitdefender GravityZone es una solución de seguridad líder para entornos virtualizados y de nube que ofrece a las organizaciones y empresas una gestión de riesgos mucho más rápida, avanzada y eficaz.
    """;
    const List<CarouselItem> solution1CarouselItems = [
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_0e6f809352bd4524a100eeea4b45bfb1~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_0e6f809352bd4524a100eeea4b45bfb1~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_3bea3acb4d444b7c92abbc4309fc4710~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_3bea3acb4d444b7c92abbc4309fc4710~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_2dee26530a184ae7a1e46cb7bceeccc1~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_2dee26530a184ae7a1e46cb7bceeccc1~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_7266d5f57d194737a56032c54672dabc~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_7266d5f57d194737a56032c54672dabc~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_97fcd8ad63784bd7abc7a769bf493374~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_97fcd8ad63784bd7abc7a769bf493374~mv2.png', 
        type: ImageType.network
      ),
    ];
    const solution1PDFPath = 'https://www.issolutions.com.ec/_files/ugd/08b335_f399809d1f264190b5528328d28dc5fa.pdf';
    const solution1PDF = File(
      fileType: FileType.pdf, 
      fileSource: FileSource.network, 
      path: solution1PDFPath
    );

    const String description2 = 
    """
    Bitdefender es una solución potente y liviana, mundialmente reconocida y premiada por su altísimo desempeño y bajo impacto en el rendimiento del computador. Durante este 2020 fue catalogada por AV-Comparatives, como el """;
    const String description2Bold = 
    """"Antivirus del Año".
    """;

    const List<CarouselItem> solution2CarouselItems = [
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_8ce363a91a764710b839ec8b86dca542~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_8ce363a91a764710b839ec8b86dca542~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_36f7fcf986064092a04f1e3d70c7bd83~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_36f7fcf986064092a04f1e3d70c7bd83~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_2e6af942de4a42ec8f256cfd97b2bcdc~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_2e6af942de4a42ec8f256cfd97b2bcdc~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_c586d825f23a412ca08ceb941f580017~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_c586d825f23a412ca08ceb941f580017~mv2.png', 
        type: ImageType.network
      )
    ];

    const solution2Path = 'https://bitdefenderecuador.com/';




    const String description3 = 
    """
    Se trata de una plataforma de simulación de ataques de ingeniería social, para conocer el nivel de respuesta de los colaboradores ante posibles amenazas; además, se complementa con un sistema de e-learning y evaluación.
    """;

    const List<CarouselItem> solution3CarouselItems = [
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_bd8149cbbf0642afb3ab32867663ed88~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_bd8149cbbf0642afb3ab32867663ed88~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_c05605c86838489e89a4a40e84dca2b2~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_c05605c86838489e89a4a40e84dca2b2~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_6a16de0bbfa849039ab441a717bdf22b~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_6a16de0bbfa849039ab441a717bdf22b~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_39e5ac8e39574d429dd7f0a56f83f0b1~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_39e5ac8e39574d429dd7f0a56f83f0b1~mv2.png', 
        type: ImageType.network
      ),
      CarouselItem(
        path: 'https://static.wixstatic.com/media/08b335_0df4b15d98ed4f2db291405158ee7fd5~mv2.png/v1/fill/w_378,h_248,al_c,q_80,usm_0.66_1.00_0.01/08b335_0df4b15d98ed4f2db291405158ee7fd5~mv2.png', 
        type: ImageType.network
      )
    ];

    const solution3PDFPath = 'https://www.issolutions.com.ec/_files/ugd/08b335_1f1d39b1d8e544ef8704ced424ff5215.pdf';
    const solution3PDF = File(
      fileType: FileType.pdf, 
      fileSource: FileSource.network, 
      path: solution3PDFPath
    );



    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: AppColors.primaryBgColor,
          )
        ),
        Positioned.fill(
          child: 
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.fromLTRB(2, 6, 2, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      mainTitle,
                      style: AppTypography.solutionsTitle,
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    _Solution(
                      logoPath: 'assets/images/logo-bitdefender-black.webp', 
                      description: description1,
                      category: 'Empresas',
                      carouselItems: solution1CarouselItems,
                      solutionPDF: solution1PDF,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    _Solution(
                      logoPath: 'assets/images/logo-bitdefender-black.webp', 
                      personalizedDescription: [
                        const TextSpan(
                        text: description2,
                        style: AppTypography.descriptionText,
                      ),
                        TextSpan(
                          text: description2Bold,
                          style: AppTypography.descriptionTextBold
                        )
                      ],
                      category: 'Hogar',
                      carouselItems: solution2CarouselItems,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    _Solution(
                      logoPath: 'assets/images/logo-attack-simulator.webp', 
                      description: description3,
                      carouselItems: solution3CarouselItems,
                      solutionPDF: solution3PDF,
                    ),
                  ],
                ),
              ),
            ) 
        )
      ],
    );

  }

}

class _Solution extends StatelessWidget{

  final String logoPath;
  final String? category;
  final String? description;
  final List<TextSpan>? personalizedDescription;
  final List<CarouselItem>? carouselItems;
  final File? solutionPDF;
  final VoidCallback? onBtnPressedPersonalizedCB;

  const _Solution({
    required this.logoPath,
    this.category,
    this.description,
    this.personalizedDescription,
    this.carouselItems,
    this.solutionPDF,
    this.onBtnPressedPersonalizedCB
  });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Image.asset(
                      logoPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if(category != null)
                    Text(
                      category!,
                      style: AppTypography.solutionsCategory,
                      textAlign: TextAlign.left,
                    )
                ],  
              )
            ),
            SizedBox(width: 12,),
            DesignedButton(
              label: "CONOCER MÁS",
              isRounded: true,
              onPressed: onBtnPressedPersonalizedCB ?? (){
                if(solutionPDF != null){
                  context.read<FileCubit>().fileChanged(solutionPDF!);
                  context.push('/pdf-viewer');
                }
              }
            )
          ],
        ),
        SizedBox(height: 20,),
        Text.rich(
          TextSpan(
            style: AppTypography.descriptionText,
            children: [
              if(personalizedDescription != null)
                TextSpan(
                    children: [...personalizedDescription!],
                    style: AppTypography.descriptionText,
                ) 
              else if(description != null)
                TextSpan(
                  text: description,
                  style: AppTypography.descriptionText,
                )  
            ]
          ),
          textAlign: TextAlign.justify,
        ),
        if(carouselItems != null)
          ImageCarousel(
            items: carouselItems!
          )
      ],
    );
  }

}

class _LinkConfirmationDialog extends StatelessWidget {
  
  final String url;

  const _LinkConfirmationDialog({required this.url});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Abrir enlace externo"),
      content: Text("¿Deseas salir de la app para ver $url?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancelar"),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Abrir"),
        ),
      ],
    );
  }
}

