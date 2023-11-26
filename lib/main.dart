import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies/widgets/favScreen.dart';
import 'package:movies/widgets/toprated.dart';
import 'package:movies/widgets/trending.dart';
import 'package:movies/widgets/tv.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'material/fav.dart';
import 'material/modified_text.dart';

void main() => runApp(
    ChangeNotifierProvider(
        create: (context) => FavoriteProvider(),
        child: MyApp(),),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<List<dynamic>> fetchData() async {
    final String apikey = '67af5e631dcbb4d0981b06996fcd47bc';
    final String readaccesstoken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2N2FmNWU2MzFkY2JiNGQwOTgxYjA2OTk2ZmNkNDdiYyIsInN1iI6IjYwNzQ1OTA0ZjkyNTMyMDAyOTFmZDczYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.C_Bkz_T8OybTGo3HfYsESNjN46LBYdw3LHdF-1TzYYs';
    List trendingmovies = [];
    List topratedmovies = [];
    List tv = [];

    try {
      TMDB tmdbWithCustomLogs = TMDB(
        ApiKeys(apikey, readaccesstoken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ),
      );

      Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
      Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
      Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();

      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
      print(tv);

    } catch (error) {
      print('Error fetching data: $error');
      // Show a dialog for network error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Network Error'),
            content: Text('There was a problem connecting to the network.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the current dialog
                  widget._refreshIndicatorKey.currentState?.show(); // Trigger refresh
                },
                child: Text('Refresh'),
              ),
            ],
          );
        },
      );

    }

    return [trendingmovies, topratedmovies, tv];
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: widget._refreshIndicatorKey,
      onRefresh: () async {
        await fetchData();
      },
      child: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitFoldingCube(
              color: Colors.white,
              size: 50.0,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            // Data has been loaded successfully
            List trendingmovies = snapshot.data?[0];
            List topratedmovies = snapshot.data?[1];
            List tv = snapshot.data?[2];

            return Home(topratedmovies, trendingmovies, tv);
          }
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  Home(this.topratedmovies, this.trendingmovies, this.tv);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoriteScreen()),
      );
    },
    child: Icon(Icons.favorite),
    ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const modified_text(
          text: 'Flutter Movie App ',
          color: Colors.white,
          size: 20,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          TV(tv: widget.tv),
          TrendingMovies(
            trending: widget.trendingmovies,
          ),
          TopRatedMovies(
            toprated: widget.topratedmovies,
          ),
        ],
      ),
    );
  }
}
