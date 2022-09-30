import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key, required this.songUrl}) : super(key: key);

  final String songUrl;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer player = AudioPlayer();
  bool loading =true;
  late Duration total;

  @override
  void initState() {
    player.setUrl(widget.songUrl).then((value){
      total=value!;
      setState(() {
        loading=false;
        player.play();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: loading?const Center(child: CircularProgressIndicator(),):Column(
          children: [
            StreamBuilder<Duration>(
              stream: player.positionStream,
              builder: (context, snapshot) {
                return Slider(
                  min: 0,
                  max: player.duration==null?0:player.duration!.inMilliseconds.toDouble(),
                  value: snapshot.data!.inMilliseconds.toDouble(),
                  onChanged: (val) {
                    player.seek(Duration(milliseconds: val.toInt()));
                  });
              }
            ),
          ],
        ));
  }


  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
