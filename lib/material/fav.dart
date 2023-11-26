import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  Set<String> _favorites = {};

  Set<String> get favorites => _favorites;

  void toggleFavorite(String movieId) {
    if (_favorites.contains(movieId)) {
      _favorites.remove(movieId);
    } else {
      _favorites.add(movieId);
    }
    notifyListeners();
  }

  bool isFavorite(String movieId) {
    return _favorites.contains(movieId);
  }
}
