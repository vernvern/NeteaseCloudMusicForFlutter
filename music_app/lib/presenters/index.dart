import 'package:flutter/material.dart';

import 'package:music_app/models.dart';
import 'package:music_app/view/util.dart';

abstract class MusicButtonContract {
  AnimationController animationController;
}

class MusicButtonPresenter {
  MusicButtonContract _view;

  MusicButtonPresenter(this._view) {}

  _open() {
    if (this._view.animationController.isDismissed) {
      this._view.animationController.forward();
    }
  }

  _close() {
    if (this._view.animationController.isCompleted) {
      this._view.animationController.reverse();
    }
  }

  onFabTap() {
    if (this._view.animationController.isDismissed) {
      _open();
    } else {
      _close();
    }
  }

  void dispose() {
    this._view.animationController.dispose();
  }
}

List<Song> _songList = [
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

abstract class IndexViewContrack {}

class IndexViewPresenter {
  _SongPresenter songPresenter;
  IndexViewContrack _view;
  List<Song> songList;

  GlobalKey<AnimatedListState> listKey = new GlobalKey<AnimatedListState>();

  bool showOnlyCompleted = false;

  IndexViewPresenter(this._view) {
    songList = _songList;
    songPresenter = new _SongPresenter(listKey, songList);
  }

  Widget changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    songList.where((song) => song.author == 'author1').forEach((song) {
      if (showOnlyCompleted) {
        songPresenter.removeAt(songPresenter.indexOf(song));
      } else {
        songPresenter.insert(songList.indexOf(song), song);
      }
    });
  }
}

class _SongPresenter {
  _SongPresenter(this.listKey, items) : this.items = new List.of(items);
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
        (context, animation) => SongRow(
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
