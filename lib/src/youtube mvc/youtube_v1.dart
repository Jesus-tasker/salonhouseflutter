import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:salonhouse/src/models/materias_elegir.dart';
import 'package:salonhouse/src/youtube%20mvc/videolist_v1.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//import 'video_list.dart';

// Creates [YoutubePlayerDemoApp] widget.
class YoutubePlayerDemoApp extends StatelessWidget {
  YoutubePlayerDemoApp(this.material_selecte0);
  Materias material_selecte0;

  @override
  Widget build(BuildContext context) {
    //final _materia=
    return Container(child: MyHomePage_video(material_selecte0));

    /* MaterialApp(
      debugShowCheckedModeBanner: false,
      //  title: 'ver lista !',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.blueAccent,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 20.0,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.blueAccent,
        ),
      ),
      home: MyHomePage_video(),
    );*/
  }
}

/// Homepage
class MyHomePage_video extends StatefulWidget {
  MyHomePage_video(this.material_selecte0);
  Materias material_selecte0;
  // MyHomePage_video(Materias material_selected);

  @override
  _MyHomePage_videoState createState() =>
      _MyHomePage_videoState(material_selecte0);
}

class _MyHomePage_videoState extends State<MyHomePage_video> {
  _MyHomePage_videoState(this.material_selecte0);

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  Materias material_selecte0;

  List<String> _ids_productos = [
    'JmSIQd6_dpg',
    'QK0TvpP7jMA',
  ];

  @override
  void initState() {
    _validaryasignar_listas();
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids_productos.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  //creado por mi //asigno listas imagenes y todo para el funcionamiento de los videos
  _validaryasignar_listas() {
    var grade = material_selecte0.materia;
    switch (grade) {
      case "Tintura de Canas":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              "6o0flos1uXg", //cubrir canas
              'pTpFEW0CGFQ',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;
      case "Cabello Brillante":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              "lRoKpEnptoY",
              "6o0flos1uXg", //cubrir canas
            ];
          });
        }
        break;
      case "Rubio Oxidado":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              "IlLKJuW9dCY",
              "lRoKpEnptoY",
              "6o0flos1uXg", //cubrir canas
            ];
          });
        }
        break;
      case "Cabello Quebradizo":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              "ZJYVgnkgIU0",
              "lRoKpEnptoY",
              "6o0flos1uXg", //cubrir canas
            ];
          });
        }
        break;
      case "Cabello Destrozado por Decoloracion":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              "gTrcC7nxYoM",
              "ZJYVgnkgIU0",
              "lRoKpEnptoY",
              "6o0flos1uXg", //cubrir canas
            ];
          });
        }
        break;
      //--
      case "Cabello Quimicamente Tratado":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              "voGnQP30cpw",
              "ZJYVgnkgIU0",
              "lRoKpEnptoY",
              "6o0flos1uXg", //cubrir canas
            ];
          });
        }
        break;
      case "pelu dama":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              "6o0flos1uXg", //cubrir canas
              'pTpFEW0CGFQ',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;

      case "Solo Uñas":
        {
          //statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'EnpPiOqLHug',
              'EnpPiOqLHug',
            ];
          });
        }
        break;

      case "Peluqueria Barberia":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'akK8SCo_fFk',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;
      case "Color capilar Mujer":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'SbLoj0OIFdM',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;
      case "Color capilar hombre":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'ouUovMvAuUg',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;
      case "Masajes Reductivos":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'BrCJhZsLw_g',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;
// hasta aqui ya tengo  los servicios
      case "mi cabello":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'V3H1c95bpjk',
              'Kk30YdUwxvg',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;
      case "Cuidada tu piel":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'WcSvfD-rEyI',
              'ZsNybWWna-M',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;
      case "Productos barber":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'BrCJhZsLw_g',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;

      case "Tintes y color":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'BrCJhZsLw_g',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;

      case "Maquinas":
        {
          // statements;
          print(grade);
          setState(() {
            _ids_productos = [
              'BrCJhZsLw_g',
              'QK0TvpP7jMA',
            ];
          });
        }
        break;

      default:
        {
          //statements;
        }
        break;
    }
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller.load(_ids_productos[
              (_ids_productos.indexOf(data.videoId) + 1) %
                  _ids_productos.length]);
          _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            /*child: Image.asset(
              'assets/ypf.png',
              fit: BoxFit.fitWidth,
            ),*/
          ),
          title: const Text(
            ' Videos instructivos',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.video_library),
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => VideoList(),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: player),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  Container(
                    height: 15,
                    child: Row(
                      children: <Widget>[
                        const Text(
                          "Volume",
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                        Expanded(
                          child: Slider(
                            inactiveColor: Colors.transparent,
                            value: _volume,
                            min: 0.0,
                            max: 100.0,
                            divisions: 10,
                            label: '${(_volume).round()}',
                            onChanged: _isPlayerReady
                                ? (value) {
                                    setState(() {
                                      _volume = value;
                                    });
                                    _controller.setVolume(_volume.round());
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _space,
                  Container(
                      height: 15, child: _text('Title', _videoMetaData.title)),
                  /*    _space,
                  _text('Channel', _videoMetaData.author),
                  _space,
                  _text('Video Id', _videoMetaData.videoId),*/
                  /* _space,
                  Row(
                    children: [
                      _text(
                        'Playback Quality',
                        _controller.value.playbackQuality ?? '',
                      ),
                      const Spacer(),
                      _text(
                        'Playback Rate',
                        '${_controller.value.playbackRate}x  ',
                      ),
                    ],
                  ),
                  //elimino opciones de descarga y vistas extra para ingresar un url
                   _space,
             ¨     TextField(
                    enabled: _isPlayerReady,
                    controller: _idController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter youtube \<video id\> or \<link\>',
                      fillColor: Colors.blueAccent.withAlpha(20),
                      filled: true,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.blueAccent,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _idController.clear(),
                      ),
                    ),
                  ),
                  _space,
                  Row(
                    children: [
                      _loadCueButton('LOAD'),
                      const SizedBox(width: 10.0),
                      _loadCueButton('CUE'),
                    ],
                  ),
                  */
                  _space, //botones de reproduccion
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          onPressed: _isPlayerReady
                              ? () => _controller.load(_ids_productos[
                                  (_ids_productos.indexOf(
                                              _controller.metadata.videoId) -
                                          1) %
                                      _ids_productos.length])
                              : null,
                        ),
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: _isPlayerReady
                              ? () {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                  setState(() {});
                                }
                              : null,
                        ),
                        IconButton(
                          icon:
                              Icon(_muted ? Icons.volume_off : Icons.volume_up),
                          onPressed: _isPlayerReady
                              ? () {
                                  _muted
                                      ? _controller.unMute()
                                      : _controller.mute();
                                  setState(() {
                                    _muted = !_muted;
                                  });
                                }
                              : null,
                        ),
                        FullScreenButton(
                          controller: _controller,
                          color: Colors.blueAccent,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          onPressed: _isPlayerReady
                              ? () => _controller.load(_ids_productos[
                                  (_ids_productos.indexOf(
                                              _controller.metadata.videoId) +
                                          1) %
                                      _ids_productos.length])
                              : null,
                        ),
                      ],
                    ),
                  ),
                  _space,
                  /* AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: _getStateColor(_playerState),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _playerState.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                    VideoList(),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                        _idController.text,
                      ) ??
                      '';
                  if (action == 'LOAD') _controller.load(id);
                  if (action == 'CUE') _controller.cue(id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

///////////-----------------Solo para compra de producto unico
/////pasar a  otra actividad para compras ...

}

//---- listas de informacion en caso de seleccion y uso de videos 2 o 3 por ahora esta bien
