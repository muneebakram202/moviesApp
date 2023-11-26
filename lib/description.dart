import 'package:animated_react_button/animated_react_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/material/toggleAnimtion.dart';
import 'package:provider/provider.dart';
import 'material/fav.dart';
import 'material/modified_text.dart';

class Description extends StatefulWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;

  const Description(
      {
        required this.name,
        required this.description,
        required this.bannerurl,
        required this.posterurl,
        required this.vote,
        required this.launch_on});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> with TickerProviderStateMixin {
  late AnimationController _favoriteController;
   Color defaultColor= Colors.grey;
   Color activeColor=Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoriteController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _favoriteController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,

      body: Container(
        child: ListView(children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: modified_text(text: '⭐ Average Rating - ' + widget.vote, color: Colors.white, size: 20,)),
                Positioned(
                  bottom: 10,
                  right: 20,
                  child: Container(
                      child: AnimatedtoggleButton(
                          defaultColor:defaultColor,
                          reactColor: activeColor,
                          onPressed: ()async{
                        // Toggle the favorite status
                        favoriteProvider.toggleFavorite(widget.name);

                        if (_favoriteController.status == AnimationStatus.dismissed) {
                          _favoriteController.reset();
                          _favoriteController.animateTo(0.6);
                          defaultColor=Colors.grey;
                          activeColor=Colors.red;
                        } else {
                          activeColor=Colors.grey;
                          _favoriteController.reverse();

                        }
                        //Simulated api/io waiting calls
                        await Future.delayed(Duration(seconds:1));
                      },  controller: _favoriteController),


                      )
                  ),
                 ],)),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(10),
              child: modified_text(
                  text: widget.name != null ? widget.name : 'Not Loaded', size: 24, color: Colors.white,)),
          Container(
              padding: EdgeInsets.only(left: 10),
              child:
              modified_text(text: 'Releasing On - ' + widget.launch_on, size: 14, color: Colors.white,)),
          Row(
            children: [
              Container(
                height: 200,
                width: 100,
                child: Image.network(widget.posterurl),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: modified_text(text: widget.description, size: 18, color: Colors.white,)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}