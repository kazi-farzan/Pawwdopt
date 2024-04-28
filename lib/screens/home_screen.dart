import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:doggie_shop/utilities/api_service.dart';
import 'package:doggie_shop/utilities/local_storage_service.dart';

//TODO: Change the way api calling is done instead of calling it once, run it again when all the cards are over

class DogImage {
  final String imageUrl;
  final String breedName;

  DogImage({required this.imageUrl, required this.breedName});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DogImage> dogImages = [];

  @override
  void initState() {
    super.initState();
    _fetchDogImages();
  }

  Future<void> _fetchDogImages() async {
    // Fetch dog images from API
    List<DogImage> newDogImages = [];
    for (int i = 0; i < 7; i++) {
      String imageUrl = await ApiService.fetchRandomDogImage();
      String breedName = _parseBreedName(imageUrl);
      newDogImages.add(DogImage(imageUrl: imageUrl, breedName: breedName));
    }
    setState(() {
      dogImages = newDogImages;
    });
  }


  String _parseBreedName(String imageUrl) {
    List<String> parts = imageUrl.split('/');
    return parts[parts.length - 2]; // Assuming breed name is second to last part in the URL
  }

  void _addToCart(DogImage dogImage) {
    setState(() {
      dogImages.remove(dogImage);
    });
    LocalStorageService.addToCart(dogImage.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PAWDOPT'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchDogImages,
        child: Center(
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onDoubleTap: () {
                  DogImage dogImage = dogImages[index];
                  _addToCart(dogImage);
                },
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          dogImages[index].imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            color: Colors.black54,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              dogImages[index].breedName,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w100,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: dogImages.length,
            viewportFraction: 0.8,
            itemHeight: 800.0,
            itemWidth: 500.0,
            loop: false,
            layout: SwiperLayout.TINDER,
            onIndexChanged: (index) {
              if (index == dogImages.length - 1) {
                _fetchDogImages();
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to view cart screen
            Navigator.pushNamed(context, '/cart', arguments: dogImages.map((image) => image.imageUrl).toList());
          },
          child: Text('View Cart'),
        ),
      ),
    );
  }

}


class AnimatedHeart extends StatefulWidget {
  @override
  _AnimatedHeartState createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200.0,
      left: 175.0,
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(
          Icons.favorite,
          color: Color(0xFFff4c68),
          size: 200.0,
        ),
      ),
    );
  }
}
