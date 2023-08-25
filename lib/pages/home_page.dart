import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:audio_player/extension/my_extension.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //varriables
  bool changeSong = false;
  double songVolume = 1.0;
  double songSpeed = 1.0;

  //create instance
  final AudioPlayer audioPlayer = AudioPlayer();
  //create duration
  Duration? duration;

  //create timer
  Timer? timer;

  //name of the music and artist
  String artistName = 'Rohan Saridena';
  String songName = 'Astronaut In The Ocean';

  String artistName2 = 'Unknown';
  String songName2 = 'Really Slow Motion';

  //load audios functions...

  loadAudioOne() async {
    //load the music from asset folder
    await audioPlayer
        .setAsset(
      "assets/Rohan Saridena - Astronaut In The Ocean - Remix.mp3",
    )
        .then(
      (value) {
        //after load the audio
        duration = value;
        //play audio
        audioPlayer.play();

        //set the timer (200 milliseconds)
        timer = Timer.periodic(
          const Duration(milliseconds: 200),
          (timer) {
            //check and rebuild Ui
            //for update current position of
            //music
            setState(
              () {},
            );
          },
        );

        audioPlayer.setLoopMode(LoopMode.all);

        //rebuild UI again
        setState(() {});
      },
    );
  }

  loadAudioTwo() async {
    audioPlayer.stop();
    //load the music from asset folder
    await audioPlayer
        .setAsset(
      "assets/Really Slow Motion.mp3",
    )
        .then(
      (value) {
        //after load the audio
        duration = value;
        //play audio
        audioPlayer.play();

        //set the timer (200 milliseconds)
        timer = Timer.periodic(
          const Duration(milliseconds: 200),
          (timer) {
            //check and rebuild Ui
            //for update current position of
            //music
            setState(
              () {},
            );
          },
        );
        audioPlayer.setLoopMode(LoopMode.all);

        //rebuild UI again
        setState(() {});
      },
    );
  }

  //cover of audio
  Container coverOfAudio() {
    return Container(
      height: 260.0,
      width: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: ExactAssetImage(
            changeSong ? "assets/cover_2.jpg" : 'assets/music_cover.jpeg',
          ),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
    );
  }

  //blur covers of audios
  Container blurCover() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage(
            changeSong ? "assets/cover_2.jpg" : "assets/music_cover.jpeg",
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8.0,
          sigmaY: 8.0,
        ),
        child: Container(),
      ),
    );
  }

  //speed of audio
  showAndSetSpeed() async {
    return await showModalBottomSheet(
      context: context,
      elevation: 10.0,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            gradient: LinearGradient(
              colors: <Color>[
                Colors.green.shade900,
                Colors.green,
                Colors.greenAccent,
                Colors.greenAccent,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    songSpeed = 0.5;
                    audioPlayer.setSpeed(songSpeed);
                  });
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.speed_rounded,
                  color: Colors.black,
                ),
                label: const Text(
                  '0.5',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    songSpeed = 1.0;
                    audioPlayer.setSpeed(songSpeed);
                  });
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.speed_rounded,
                  color: Colors.black,
                ),
                label: const Text(
                  '1.0',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    songSpeed = 2.0;
                    audioPlayer.setSpeed(songSpeed);
                  });
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.speed_rounded,
                  color: Colors.black,
                ),
                label: const Text(
                  "2.0",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //volume down
  volumeDown() {
    if (audioPlayer.volume > 0.1) {
      setState(() {
        songVolume -= 0.1;
      });
      audioPlayer.setVolume(songVolume);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.greenAccent.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
          shape: const CircleBorder(),
          margin: const EdgeInsets.only(
            bottom: 350.0,
            top: 350.0,
          ),
          duration: const Duration(
            milliseconds: 200,
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.volume_down,
                ),
                Text(
                  (audioPlayer.volume * 100).toInt().toString(),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  //volume up
  volumeUp() {
    if (audioPlayer.volume < 1.0) {
      setState(() {
        songVolume += 0.1;
      });
      audioPlayer.setVolume(songVolume);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.greenAccent.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
          shape: const CircleBorder(),
          margin: const EdgeInsets.only(
            bottom: 350.0,
            top: 350.0,
          ),
          duration: const Duration(
            milliseconds: 200,
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.volume_up,
                ),
                Text(
                  (audioPlayer.volume * 100).toInt().toString(),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  //show all list of audios
  listOfAudios() async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          height: 200.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            gradient: LinearGradient(
              colors: <Color>[
                Colors.green.shade900,
                Colors.green,
                Colors.greenAccent,
                Colors.greenAccent,
              ],
            ),
          ),
          child: ListView(
            children: <Widget>[
              //audio number 1
              GestureDetector(
                onTap: () async {
                  setState(() {
                    changeSong = false;
                  });
                  audioPlayer.stop();
                  await loadAudioOne();

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: Card(
                  color: Colors.black38,
                  child: ListTile(
                    title: Text(
                      songName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      artistName,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Text(
                      '4:20',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: Image.asset(
                          'assets/music_cover.jpeg',
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //audio number 2
              GestureDetector(
                onTap: () async {
                  setState(() {
                    changeSong = true;
                  });
                  await loadAudioTwo();

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: Card(
                  color: Colors.black38,
                  child: ListTile(
                    title: Text(
                      songName2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      artistName2,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Text(
                      '3:14',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: Image.asset(
                          'assets/cover_2.jpg',
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    loadAudioOne();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text(
          'Audio player',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          //background
          Positioned.fill(
            child: blurCover(),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  coverOfAudio(),
                  const SizedBox(
                    height: 10.0,
                  ),

                  //name of audio
                  Text(
                    changeSong ? songName2 : songName,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),

                  //name of artist
                  Text(
                    changeSong ? artistName2 : artistName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),

                  //Slider for seek of audio
                  if (duration != null)
                    Slider(
                      thumbColor: Colors.greenAccent,
                      inactiveColor: Colors.black,
                      activeColor: Colors.greenAccent,
                      //convert duration of audio
                      max: duration!.inMilliseconds.toDouble(),
                      //convert duration of audio
                      value: audioPlayer.position.inMilliseconds.toDouble(),
                      onChanged: (value) {
                        //drag the slider to where we want
                        audioPlayer.seek(
                          Duration(
                            milliseconds: value.toInt(),
                          ),
                        );
                      },
                      onChangeStart: (value) {
                        //when we dragging the slider
                        //the audio state turn to pause
                        audioPlayer.pause();
                      },
                      onChangeEnd: (value) {
                        //when dragging is done
                        //the audio will play again
                        audioPlayer.play();
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    //Row (for long of audios (Start and end Time))
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //start
                        Text(
                          audioPlayer.position.toMinutesSeconds(),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: changeSong ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        //end
                        if (duration != null)
                          Text(
                            duration!.toMinutesSeconds(),
                            style: TextStyle(
                              fontSize: 12.0,
                              color: changeSong ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  //controll panel
                  Container(
                    height: 120.0,
                    width: 320.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.green.shade900,
                          Colors.green,
                          Colors.greenAccent,
                          Colors.greenAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // previous - play/pause - next --start
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //change audio
                            IconButton(
                              onPressed: () async {
                                if (changeSong == false) {
                                  setState(() {
                                    changeSong = !changeSong;
                                  });
                                  await loadAudioTwo();
                                } else if (changeSong == true) {
                                  setState(() {
                                    changeSong = !changeSong;
                                  });

                                  audioPlayer.stop();
                                  await loadAudioOne();
                                }
                              },
                              icon: const Icon(
                                Icons.keyboard_double_arrow_left,
                                size: 40.0,
                                color: Colors.black,
                              ),
                              color: Colors.white,
                            ),
                            GestureDetector(
                              onTap: () {
                                audioPlayer.playing
                                    ? audioPlayer.pause()
                                    : audioPlayer.play();
                              },
                              child: Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  audioPlayer.playing
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 40.0,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                if (changeSong == false) {
                                  setState(() {
                                    changeSong = !changeSong;
                                  });
                                  await loadAudioTwo();
                                } else if (changeSong == true) {
                                  setState(() {
                                    changeSong = !changeSong;
                                  });

                                  audioPlayer.stop();
                                  await loadAudioOne();
                                }
                              },
                              icon: const Icon(
                                Icons.keyboard_double_arrow_right,
                                size: 40.0,
                                color: Colors.black,
                              ),
                              color: Colors.white,
                            ),
                          ],
                        ),

                        // previous - play/pause - next --end
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //speed of audio --start
                            IconButton(
                              onPressed: () async {
                                await showAndSetSpeed();
                              },
                              icon: const Icon(
                                Icons.speed_sharp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              songSpeed.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //speed of audio --end
                            const SizedBox(
                              width: 30.0,
                            ),

                            //volume down...
                            IconButton(
                              onPressed: () {
                                volumeDown();
                              },
                              icon: const Icon(
                                Icons.volume_down,
                                color: Colors.black,
                              ),
                            ),
                            //volume up...
                            IconButton(
                              onPressed: () {
                                volumeUp();
                              },
                              icon: const Icon(
                                Icons.volume_up,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 60.0,
                            ),

                            //list of audios
                            IconButton(
                              onPressed: () async {
                                await listOfAudios();
                              },
                              icon: const Icon(
                                Icons.library_music_sharp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
