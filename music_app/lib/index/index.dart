import 'package:flutter/material.dart';
import 'dart:math' as math;

import './song.dart';

class Index extends StatefulWidget {
  @override
  createState() => new IndexState();
}

List<Song> songList = [
  new Song(link: 'link1', title: 'title1', author: 'author1'),
  new Song(link: 'link2', title: 'title2', author: 'author2'),
  new Song(link: 'link3', title: 'title3', author: 'author3'),
  new Song(link: 'link4', title: 'title4', author: 'author3'),
  new Song(link: 'link5', title: 'title5', author: 'author5'),
  new Song(link: 'link6', title: 'title6', author: 'author6'),
  new Song(link: 'link1', title: 'title1', author: 'author1'),
  new Song(link: 'link2', title: 'title2', author: 'author2'),
  new Song(link: 'link3', title: 'title3', author: 'author3'),
  new Song(link: 'link4', title: 'title4', author: 'author3'),
  new Song(link: 'link5', title: 'title5', author: 'author5'),
  new Song(link: 'link6', title: 'title6', author: 'author6'),
];

class IndexState extends State<Index> {
  double _imageHeight = 300.0;
  bool showOnlyCompleted = false;
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  SongModule songModule;

  @override
  void initState() {
    super.initState();
    songModule = new SongModule(_listKey, songList);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          _buildTimeline(),
          _buildImage(),
          _buildTopHeader(),
          _buildDetailRow(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return new Image.asset(
      'images/index.jpg',
      fit: BoxFit.fill,
      height: _imageHeight,
    );
  }

  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: new Row(
        children: <Widget>[
          new Icon(Icons.menu, size: 32.0, color: Colors.white),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text('Netease Clound Music',
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)),
            ),
          ),
          new Icon(Icons.linear_scale, color: Colors.white)
        ],
      ),
    );
  }

  Widget _buildDetailRow() {
    return Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('images/avatar.png'),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'test 1',
                  style: new TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                new Text(
                  'test2',
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight),
      child: new Row(
        children: <Widget>[
          _buildSongList(),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _buildSongList() {
    return new Expanded(
      child: new AnimatedList(
        initialItemCount: songList.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return new SongRow(
            song: songModule[index],
            animation: animation,
          );
        },
      ),
    );
  }

  Widget _buildFab() {
    return new Positioned(
      top: _imageHeight - 100.0,
      right: -40.0,
      child: new AnimatedFab(
        onClick: _changeFilterState,
      ),
    );
  }

  Widget _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    songList.where((song) => song.author == 'author1').forEach((song) {
      if (showOnlyCompleted) {
        songModule.removeAt(songModule.indexOf(song));
      } else {
        songModule.insert(songList.indexOf(song), song);
      }
    });
  }
}

class AnimatedFab extends StatefulWidget {
  final VoidCallback onClick;
  const AnimatedFab({Key key, this.onClick}) : super(key: key);

  @override
  _AnimatedFabState createState() => new _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  final double expandedSize = 180.0;
  final double hiddenSize = 20.0;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(microseconds: 200));
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
        width: expandedSize,
        height: expandedSize,
        child: new AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildExpandBackground(),
                _buildOption(Icons.check_circle, 0.0),
                _buildOption(Icons.flash_on, -math.pi / 3),
                _buildOption(Icons.access_time, -2 * math.pi / 3),
                _buildOption(Icons.error_outline, math.pi),
                _buildFabCore(),
              ],
            );
          },
        ));
  }

  Widget _buildExpandBackground() {
    double size =
        hiddenSize + (expandedSize - hiddenSize) * _animationController.value;
    return new Container(
      height: size,
      width: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  Widget _buildFabCore() {
    double scaleFactor = 2 * (_animationController.value - 0.5).abs();
    return new FloatingActionButton(
      onPressed: _onFabTap,
      child: new Transform(
          alignment: Alignment.center,
          transform: new Matrix4.identity()..scale(1.0, scaleFactor),
          child: new Icon(
            _animationController.value > 0.5 ? Icons.close : Icons.filter_list,
            color: Colors.white,
            size: 26.0,
          )),
      backgroundColor: _colorAnimation.value,
    );
  }

  open() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  close() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  _onFabTap() {
    if (_animationController.isDismissed) {
      open();
    } else {
      close();
    }
  }

  Widget _buildOption(IconData icon, double angle) {
    double iconSize = 0.0;
    if (_animationController.value > 0.0) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    return Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(top: 8.0),
          child: IconButton(
            onPressed: widget.onClick,
            icon: new Transform.rotate(
              angle: -angle,
              child: new Icon(icon, color: Colors.white),
            ),
            iconSize: iconSize,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }
}
