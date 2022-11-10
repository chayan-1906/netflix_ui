import 'package:flutter/material.dart';
import 'package:netflix_ui/models/content_model.dart';
import 'package:netflix_ui/widgets/responsive.dart';
import 'package:video_player/video_player.dart';

import 'vertical_icon_button.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({Key key, this.featuredContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({Key key, this.featuredContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(featuredContent.titleImageUrl),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                iconData: Icons.add_rounded,
                title: 'List',
                onTap: () {
                  print('My list');
                },
              ),
              const _PlayButton(),
              VerticalIconButton(
                iconData: Icons.info_outline_rounded,
                title: 'Info',
                onTap: () {
                  print('Info');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({Key key, this.featuredContent})
      : super(key: key);

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController videoPlayerController;
  bool isMute = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((value) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => videoPlayerController.value.isPlaying
          ? videoPlayerController.pause()
          : videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: videoPlayerController.value.isInitialized
                ? videoPlayerController.value.aspectRatio
                : 2.344,
            child: videoPlayerController.value.isInitialized
                ? VideoPlayer(videoPlayerController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.isInitialized
                  ? videoPlayerController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(widget.featuredContent.titleImageUrl),
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.featuredContent.description,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 4.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    const _PlayButton(),
                    const SizedBox(width: 16.0),
                    ElevatedButton.icon(
                      onPressed: () => print('More Info'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(
                          25.0,
                          10.0,
                          30.0,
                          10.0,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      icon: const Icon(
                        Icons.info_outline_rounded,
                        size: 30.0,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'More Info',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    if (videoPlayerController.value.isInitialized)
                      IconButton(
                        onPressed: () => setState(() {
                          isMute
                              ? videoPlayerController.setVolume(100)
                              : videoPlayerController.setVolume(0);
                          isMute = videoPlayerController.value.volume == 0;
                        }),
                        color: Colors.white,
                        iconSize: 30.0,
                        icon: Icon(
                          isMute
                              ? Icons.volume_off_rounded
                              : Icons.volume_up_rounded,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: !Responsive.isDesktop(context)
            ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
            : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
        backgroundColor: Colors.white,
      ),
      onPressed: () => print('Play'),
      icon: const Icon(Icons.play_arrow_rounded, color: Colors.black),
      label: const Text(
        'Play',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
