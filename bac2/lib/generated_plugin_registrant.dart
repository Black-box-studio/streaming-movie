//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  FirebaseFirestoreWeb.registerWith(registry.registrarFor(FirebaseFirestoreWeb));
  FirebaseAuthWeb.registerWith(registry.registrarFor(FirebaseAuthWeb));
  FirebaseCoreWeb.registerWith(registry.registrarFor(FirebaseCoreWeb));
  ImagePickerWeb.registerWith(registry.registrarFor(ImagePickerWeb));
  UrlLauncherPlugin.registerWith(registry.registrarFor(UrlLauncherPlugin));
  registry.registerMessageHandler();
}
