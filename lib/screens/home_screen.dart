import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:doggie_shop/utilities/api_service.dart';
import 'package:doggie_shop/utilities/local_storage_service.dart';

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
  List<DogImage> DogImages = [];

  @override
  void initState() {
    super.initState();
    _fetchDogImages();
  }

  void _fetchDogImages() async {
    // Make 7 API calls to fetch dog pictures for 7 cards
    for (int i = 0; i < 7; i++) {
      String imageUrl = await ApiService.fetchRandomDogImage();
      String breedName = _parseBreedName(imageUrl);
      setState(() {
        DogImages.add(DogImage(imageUrl: imageUrl, breedName: breedName));
      });
    }
  }



  String _parseBreedName(String imageUrl) {
    // Parse the breed name from the image URL
    List<String> parts = imageUrl.split('/');
    return parts[parts.length - 2]; // Assuming breed name is second to last part in the URL
  }

  void _addToCart(DogImage dogImage) {
    // Remove the dog image from the list when added to cart
    setState(() {
      DogImages.remove(dogImage);
    });
    LocalStorageService.addToCart(dogImage.imageUrl);
  }

  void _removeFromQueue(DogImage dogImage) {
    // Remove the dog image from the list when removed from queue
    setState(() {
      DogImages.remove(dogImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TINDOG'),
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
      body: Center(
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onDoubleTap: () {
                DogImage dogImage = DogImages[index];
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
                        DogImages[index].imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0, // Adjusted to align with both left and right edges
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjusted padding for left and right edges
                        color: Colors.black54,
                        alignment: Alignment.bottomLeft, // Adjusted alignment to bottom left
                        child: Text(
                          DogImages[index].breedName,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            );

          },
          itemCount: DogImages.length,
          viewportFraction: 0.8,
          itemHeight: 500.0,
          itemWidth: 500.0,
          loop: false,
          layout: SwiperLayout.TINDER,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to view cart screen
            Navigator.pushNamed(context, '/cart', arguments: DogImages.map((image) => image.imageUrl).toList());
          },
          child: Text('View Cart'),
        ),
      ),
    );
  }
}
