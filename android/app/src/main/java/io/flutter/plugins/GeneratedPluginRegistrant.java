package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin cloud_firestore, io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.connectivity.ConnectivityPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin connectivity_plus, dev.fluttercommunity.plus.connectivity.ConnectivityPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_auth, io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_core, io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_messaging, io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_storage, io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_plugin_android_lifecycle, io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin fluttertoast, io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.baseflow.geolocator.GeolocatorPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin geolocator_android, com.baseflow.geolocator.GeolocatorPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.github.zeshuaro.google_api_headers.GoogleApiHeadersPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin google_api_headers, io.github.zeshuaro.google_api_headers.GoogleApiHeadersPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.googlemaps.GoogleMapsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin google_maps_flutter_android, io.flutter.plugins.googlemaps.GoogleMapsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.googlesignin.GoogleSignInPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin google_sign_in_android, io.flutter.plugins.googlesignin.GoogleSignInPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin image_cropper, vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.imagepicker.ImagePickerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin image_picker_android, io.flutter.plugins.imagepicker.ImagePickerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.lyokone.location.LocationPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin location, com.lyokone.location.LocationPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.maps_launcher.MapsLauncherPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin maps_launcher, com.example.maps_launcher.MapsLauncherPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.onesignal.flutter.OneSignalPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin onesignal_flutter, com.onesignal.flutter.OneSignalPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.packageinfo.PackageInfoPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin package_info_plus, dev.fluttercommunity.plus.packageinfo.PackageInfoPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new net.touchcapture.qr.flutterqr.FlutterQrPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin qr_code_scanner, net.touchcapture.qr.flutterqr.FlutterQrPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin shared_preferences_android, io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.tekartik.sqflite.SqflitePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin sqflite, com.tekartik.sqflite.SqflitePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin url_launcher_android, io.flutter.plugins.urllauncher.UrlLauncherPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.videoplayer.VideoPlayerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin video_player_android, io.flutter.plugins.videoplayer.VideoPlayerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new creativemaybeno.wakelock.WakelockPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin wakelock, creativemaybeno.wakelock.WakelockPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.webviewflutter.WebViewFlutterPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin webview_flutter_android, io.flutter.plugins.webviewflutter.WebViewFlutterPlugin", e);
    }
  }
}
