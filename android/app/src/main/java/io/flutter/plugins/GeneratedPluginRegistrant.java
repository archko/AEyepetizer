package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
      cn.archko.flutter.base.flutter_base.FlutterBasePlugin.registerWith(shimPluginRegistry.registrarFor("cn.archko.flutter.base.flutter_base.FlutterBasePlugin"));
      top.kikt.ijkplayer.IjkplayerPlugin.registerWith(shimPluginRegistry.registrarFor("top.kikt.ijkplayer.IjkplayerPlugin"));
    flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
      com.tekartik.sqflite.SqflitePlugin.registerWith(shimPluginRegistry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
    flutterEngine.getPlugins().add(new io.flutter.plugins.webviewflutter.WebViewFlutterPlugin());
  }
}
