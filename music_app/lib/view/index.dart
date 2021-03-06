import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:music_app/models.dart';
import 'package:music_app/presenters/index.dart';
import './util.dart';

class IndexView extends StatefulWidget {
  @override
  createState() => new IndexViewState();
}

class IndexViewState extends State<IndexView> implements IndexViewContrack {
  double _imageHeight = 300.0;

  IndexViewPresenter _presenter;

  IndexViewState() {}

  @override
  void initState() {
    super.initState();
    _presenter = new IndexViewPresenter(this);
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
        initialItemCount: _presenter.songList.length,
        key: _presenter.listKey,
        itemBuilder: (context, index, animation) {
          return new SongRow(
            song: _presenter.songPresenter[index],
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
      child: new MusicButton(
        onClick: _presenter.changeFilterState,
      ),
    );
  }
}

class MusicButton extends StatefulWidget {
  final VoidCallback onClick;
  const MusicButton({Key key, this.onClick}) : super(key: key);

  @override
  _MusicButtonState createState() => new _MusicButtonState();
}

class _MusicButtonState extends State<MusicButton>
    with SingleTickerProviderStateMixin
    implements MusicButtonContract {
  MusicButtonPresenter _presenter;
  Animation<Color> _colorAnimation;
  AnimationController animationController;

  final double expandedSize = 180.0;
  final double hiddenSize = 20.0;

  _MusicButtonState() {}

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(microseconds: 200));
    _presenter = MusicButtonPresenter(this);
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(animationController);
  }

/*   @override
  void dispose() {
    _presenter.animationController.dispose();
    super.dispose();
  }
 */
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
        width: expandedSize,
        height: expandedSize,
        child: new AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildOptionBackground(),
                __buildOptionButton(Icons.check_circle, 0.0),
                __buildOptionButton(Icons.flash_on, -math.pi / 3),
                __buildOptionButton(Icons.access_time, -2 * math.pi / 3),
                __buildOptionButton(Icons.error_outline, math.pi),
                _buildMusicButton(),
              ],
            );
          },
        ));
  }

  Widget _buildOptionBackground() {
    double size =
        hiddenSize + (expandedSize - hiddenSize) * animationController.value;
    return new Container(
      height: size,
      width: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  Widget _buildMusicButton() {
    double scaleFactor = 2 * (animationController.value - 0.5).abs();
    return new FloatingActionButton(
      onPressed: _presenter.onFabTap,
      child: new Transform(
          alignment: Alignment.center,
          transform: new Matrix4.identity()..scale(1.0, scaleFactor),
          child: new Icon(
            animationController.value > 0.5 ? Icons.close : Icons.filter_list,
            color: Colors.white,
            size: 26.0,
          )),
      backgroundColor: _colorAnimation.value,
    );
  }

  Widget __buildOptionButton(IconData icon, double angle) {
    double iconSize = 0.0;
    if (animationController.value > 0.0) {
      iconSize = 26.0 * (animationController.value - 0.8) * 5;
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
