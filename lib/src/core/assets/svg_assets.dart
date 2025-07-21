import 'package:chatgpt_clone/src/core/assets/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGs {
  static Widget icon(String asset, {
    double size = 20,
    Color color = Colors.white,
    BoxFit fit = BoxFit.scaleDown,
    String? label,
  }) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      color: color,
      fit: fit,
      semanticsLabel: label,
    );
  }

  static Widget camera({double size = 20}) =>
      icon(AppIcons.camera, size: size, label: 'camera');

  static Widget edit({double size = 20}) =>
      icon(AppIcons.edit, size: size, label: 'edit');

  static Widget folder({double size = 20}) =>
      icon(AppIcons.folder, size: size, label: 'folder');

  static Widget menu({double size = 20}) =>
      icon(AppIcons.menu, size: size, label: 'menu');

  static Widget mic({double size = 20}) =>
      icon(AppIcons.mic, size: size, label: 'mic');

  static Widget photos({double size = 20}) =>
      icon(AppIcons.photos, size: size, label: 'photos');

  static Widget tempMessage({double size = 20}) =>
      icon(AppIcons.tempMessage, size: size, label: 'tempMessage');

  static Widget telescope({double size = 20}) =>
      icon(AppIcons.telescope, size: size, label: 'telescope');

  static Widget settings({double size = 20}) =>
      icon(AppIcons.settings, size: size, label: 'settings');

  static Widget lightbulb({double size = 20}) =>
      icon(AppIcons.lightbulb, size: size, label: 'lightbulb');

  static Widget globe({double size = 20}) =>
      icon(AppIcons.globe, size: size, label: 'globe');

  static Widget explore({double size = 20}) =>
      icon(AppIcons.explore, size: size, label: 'explore');

  static Widget chat({double size = 20}) =>
      icon(AppIcons.chat, size: size, label: 'chat');

  static Widget search({double size = 5}) =>
      icon(AppIcons.search, size: size, label: 'search');

  static Widget copy({double size = 16}) =>
      icon(AppIcons.copy, size: size, label: 'copy');

  static Widget like({double size = 16}) =>
      icon(AppIcons.like, size: size, label: 'like');

  static Widget dislike({double size = 16}) =>
      icon(AppIcons.dislike, size: size, label: 'dislike');

  static Widget volume({double size = 16}) =>
      icon(AppIcons.volume, size: size, label: 'volume');

  static Widget resend({double size = 16}) =>
      icon(AppIcons.resend, size: size, label: 'resend');
}