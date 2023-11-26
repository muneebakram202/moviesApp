import 'package:flutter/material.dart';
import '../description.dart';
import '../material/modified_text.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({required this.trending}) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'Trending Movies',
            size: 26, color: Colors.white,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // Check if the movie details are available
                              if (trending[index]['title'] != null &&
                                  trending[index]['backdrop_path'] != null &&
                                  trending[index]['poster_path'] != null &&
                                  trending[index]['overview'] != null &&
                                  trending[index]['vote_average'] != null &&
                                  trending[index]['release_date'] != null) {
                                return Description(
                                  name: trending[index]['title'],
                                  bannerurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['backdrop_path'],
                                  posterurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['poster_path'],
                                  description: trending[index]['overview'],
                                  vote: trending[index]['vote_average'].toString(),
                                  launch_on: trending[index]['release_date'],
                                );
                              } else {
                                // If movie details are not available, show an error message
                                return Scaffold(
                                  appBar: AppBar(
                                    title: Text('Error'),
                                  ),
                                  body: Center(
                                    child: Text(
                                      'Sorry, there was an issue fetching movie details.',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },

                      child: Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          trending[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: modified_text(
                                  size: 15,
                                  text: trending[index]['title'] != null
                                      ? trending[index]['title']
                                      : 'Loading', color: Colors.white,),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}