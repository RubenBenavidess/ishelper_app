import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; 

class ImageCarousel extends StatefulWidget {
  
  final List<CarouselItem> items;  
  final double height;
  final Curve animationCurve;
  final Duration animationDuration;
  
  const ImageCarousel({
    super.key,
    required this.items,
    this.height = 248,
    this.animationCurve = Curves.easeInOutCubic, 
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    if (page < 0 || page >= widget.items.length) return;
    
    _pageController.animateToPage(
      page,
      duration: widget.animationDuration,
      curve: widget.animationCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: 378,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return _CarouselImage(item: widget.items[index]);
            },
          ),
          // Botón Izquierda
          if (_currentIndex > 0)
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _ArrowButton(
                  icon: Icons.arrow_back_ios_new,
                  onPressed: () => _animateToPage(_currentIndex - 1),
                ),
              ),
            ),
          // Botón Derecha
          if (_currentIndex < widget.items.length - 1)
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _ArrowButton(
                  icon: Icons.arrow_forward_ios,
                  onPressed: () => _animateToPage(_currentIndex + 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

enum ImageType { network, asset }

class CarouselItem {

  final String path;
  final ImageType type;

  const CarouselItem({required this.path, required this.type});
}

class _CarouselImage extends StatelessWidget {

  final CarouselItem item; 

  const _CarouselImage({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: _buildImage(),
      );
  }

  Widget _buildImage() {
    switch (item.type) {
      
      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: item.path,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => _ErrorPlaceholder(),
          fadeInDuration: const Duration(milliseconds: 300),
        );

      case ImageType.asset:
        return Image.asset(
          item.path,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _ErrorPlaceholder(),
        );
    }
  }
}

class _ErrorPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.broken_image, color: Colors.grey, size: 40),
          SizedBox(height: 8),
          Text("No disponible", style: TextStyle(color: Colors.grey, fontSize: 12))
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(0, 0, 0, 0.3), 
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        iconSize: 20,
        splashRadius: 24, 
      ),
    );
  }
}