package com.nayidisha.jalsetu

// FIX: Change from FlutterActivity to FlutterFragmentActivity
// This is required for compatibility with many modern plugins,
// especially when multidex is enabled.
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    // No other code is needed here for this fix.
}

