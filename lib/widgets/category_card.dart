import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(
    MaterialApp(
      home: VideoSlider(),
    ),
  );
}

class VideoSlider extends StatefulWidget {
  @override
  _VideoSliderState createState() => _VideoSliderState();
}

class _VideoSliderState extends State<VideoSlider> {
  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://sample-videos.com/video123/mp4/480/asdasdas.mp4', // Replace with valid mp4 URL
  ];

  List<VideoPlayerController> controllers = [];
  int _current = 0;

  @override
  void initState() {
    super.initState();
    for (var url in videoUrls) {
      final controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
        });
      controllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void playCurrentVideo(int index) {
    for (int i = 0; i < controllers.length; i++) {
      if (i == index) {
        controllers[i].play();
      } else {
        controllers[i].pause();
        controllers[i].seekTo(Duration.zero);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Slider')),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: controllers.length,
            itemBuilder: (context, index, realIndex) {
              final controller = controllers[index];
              return controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              )
                  : Center(child: CircularProgressIndicator());
            },
            options: CarouselOptions(
              height: 250,
              autoPlay: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() => _current = index);
                playCurrentVideo(index);
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: videoUrls.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key ? Colors.orange : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
