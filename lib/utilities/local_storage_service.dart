import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void addDogToHistory(String imageUrl) {
    List<String> history = _prefs!.getStringList('dogHistory') ?? [];
    history.add(imageUrl);
    _prefs!.setStringList('dogHistory', history);
  }

  static List<String> getDogHistory() {
    return _prefs!.getStringList('dogHistory') ?? [];
  }

  static void addToCart(String imageUrl) {
    List<String> cart = _prefs!.getStringList('cart') ?? [];
    cart.add(imageUrl);
    _prefs!.setStringList('cart', cart);
  }

  static List<String> getCartItems() {
    return _prefs!.getStringList('cart') ?? [];
  }

  static void clearCart() {
    _prefs!.remove('cart');
  }
}
