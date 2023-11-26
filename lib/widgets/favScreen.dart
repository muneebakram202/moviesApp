import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../material/fav.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoriteProvider>(context);
    List<String> favoriteMovies = favoriteProvider.favorites.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          // You can customize the appearance of each favorite movie item
          return ListTile(
            title: Text(favoriteMovies[index]),
            // Add more details or widgets if needed
          );
        },
      ),
    );
  }
}
