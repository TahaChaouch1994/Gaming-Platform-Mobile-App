import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geeks_overflow/entities/stream_model.dart';
import 'package:geeks_overflow/utils/minivideo.dart';
import 'package:geeks_overflow/views/favorites_screen.dart';
import 'package:geeks_overflow/views/stream_screen.dart';
import 'package:video_player/video_player.dart';



class streamScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<streamScreen> {
  PageController _pageController;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
    _videoPlayerController1 = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );

  }
  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }
  _movieSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieScreen(movie: movies[index]),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                    tag: movies[index].imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child:  Chewie(
                        controller: _chewieController,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              bottom: 40.0,
              child: Container(
                width: 250.0,
                child: Text(
                  movies[index].title.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  _labelSelector(int index) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 160.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFD45253),
            Color(0xFF9E1F28),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF9E1F28),
            offset: Offset(0.0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => favorites_screen(),
          ),
        ),
        child: Text(
          labels[index].toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image(
          image: AssetImage('assets/images/title.jpg'),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(left: 30.0),
          onPressed: () => print('Menu'),
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 30.0),
            onPressed: () => print('Search'),
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.black,
          ),

        ],
      ),
      body:
      Stack(children: <Widget>[
        Positioned(
          //top: 100,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 100,
            color: Colors.black,
            child: minivideo(),
          ),
        ),
      ListView(
        children:<Widget>[
          Container(
            height: 250.0,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return _movieSelector(index);
              },
            ),
          ),
          Container(
            height: 90.0,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              scrollDirection: Axis.horizontal,
              itemCount: labels.length,
              itemBuilder: (BuildContext context, int index) {
                return _labelSelector(index);
              },
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    ]));
  }
}
