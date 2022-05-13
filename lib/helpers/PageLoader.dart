import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class PageLoader {
  final Completer _completer = Completer();
  final BuildContext context;

  PageLoader(this.context);

  void init() {
    context.showBlockDialog(
        dismissCompleter: _completer);
  }

  void complete() {
    _completer.complete();
  }
}
