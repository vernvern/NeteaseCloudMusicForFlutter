import 'package:flutter/material.dart';

class Song {
  String author;
  String title;
  String link;

  Song({this.author, this.title, this.link});
}

class SongRow extends StatelessWidget {
  final Song song;
  final double doSite = 12.0;
  final Animation<double> animation;
  const SongRow({Key key, this.song, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
      opacity: animation,
      child: new SizeTransition(
        sizeFactor: animation,
        child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: new Row(
            children: <Widget>[
              new Padding(
                padding:
                    new EdgeInsets.symmetric(horizontal: 32.0 - doSite / 2),
                child: new Container(
                  height: doSite,
                  width: doSite,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                ),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      song.title,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    new Text(
                      song.author,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: new Text(
                  song.link,
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SongModule {
  SongModule(this.listKey, items) : this.items = new List.of(items);
  final GlobalKey<AnimatedListState> listKey;
  final List<Song> items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, Song song) {
    items.insert((index), song);
    _animatedList.insertItem(index);
  }

  Song removeAt(int index) {
    final Song removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (context, animation) => new SongRow(
              song: removedItem,
              animation: animation,
            ),
        // duration: new Duration(microseconds: 250000.toInt()),
      );
    }
    return removedItem;
  }

  int get length => items.length;

  Song operator [](int index) => items[index];

  int indexOf(Song item) => items.indexOf(item);
}
