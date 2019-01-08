import 'package:flutter/material.dart';

import 'package:music_app/models.dart';
import 'package:music_app/view/util.dart';

abstract class MusicButtonContract {
  AnimationController animationController;
}

class MusicButtonPresenter implements MusicButtonContract {
  MusicButtonContract _view;
  AnimationController animationController;

  MusicButtonPresenter(this._view) {
    animationController = _view.animationController;
  }

  _open() {
    if (animationController.isDismissed) {
      animationController.forward();
    }
  }

  _close() {
    if (animationController.isCompleted) {
      animationController.reverse();
    }
  }

  onFabTap() {
    if (animationController.isDismissed) {
      _open();
    } else {
      _close();
    }
  }

  void dispose() {
    animationController.dispose();
  }
}

class SongPresenter {
  SongPresenter(this.listKey, items) : this.items = new List.of(items);
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
