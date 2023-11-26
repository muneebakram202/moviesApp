

import 'package:flutter/material.dart';

import '../material/modified_text.dart';

class TV extends StatelessWidget {
  final List tv;

  const TV({ required this.tv}) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'Popular TV Shows',
            size: 26, color: Colors.white,
          ),
          SizedBox(height: 10),
          Container(
            // color: Colors.red,
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tv.length,
                  itemBuilder: (context, index) {
                    // Check if the required data is available
                    if (tv[index]['backdrop_path'] != null &&
                        tv[index]['original_name'] != null) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        width: 250,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        tv[index]['backdrop_path'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 140,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: modified_text(
                                size: 15,
                                text: tv[index]['original_name'],
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      // If required data is missing, show a placeholder or an error message
                      return Container(
                        padding: EdgeInsets.all(5),
                        width: 250,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey, // Placeholder color
                              ),
                              height: 140,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: modified_text(
                                size: 15,
                                text: 'Error loading TV show',
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }
              ))
        ],
      ),
    );
  }
}