package com.nayidisha.jalsetu

// FIX: Change FlutterActivity to FlutterFragmentActivity.
// Some plugins, especially those that interact with native Android UI or services
// like Google Sign-In, require the Fragment-based activity to function correctly.
// This is a common and critical fix for plugin compatibility.
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    // No need to override configureFlutterEngine() unless you have custom platform channels.
    // The base class handles plugin registration.
}
