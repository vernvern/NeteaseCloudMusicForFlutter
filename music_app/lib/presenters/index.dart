import 'package:flutter/material.dart';

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
