

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class minivideo extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<minivideo> {

  VideoPlayerController viewPlayerController;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    viewPlayerController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..initialize().then((_) {});
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
    viewPlayerController.pause();
    super.dispose();
    _videoPlayerController1.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width/2;
    var height = 100.0; //MediaQuery.of(context).size.height-200;

    VideoPlayer videoPlayer = new VideoPlayer(this.viewPlayerController,);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child:Container (
              child:Chewie(
        controller: _chewieController,
      ),

            width: width,
            height: height,
          )),

        ],
      ),
    );
  }
}
