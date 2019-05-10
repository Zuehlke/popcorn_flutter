package com.zuehlke.camp.flutter.PopcornMaker

import android.os.Build
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import android.view.WindowManager
import android.view.ViewTreeObserver


class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        //Remove full screen flag after load
        val vto = flutterView.viewTreeObserver
        vto.addOnGlobalLayoutListener(object : ViewTreeObserver.OnGlobalLayoutListener {
            override fun onGlobalLayout() {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                    flutterView.viewTreeObserver.removeOnGlobalLayoutListener(this)
                }
                window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
            }
        })
    }
}
