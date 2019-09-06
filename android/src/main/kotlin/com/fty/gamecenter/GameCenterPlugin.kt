package com.fty.gamecenter

import android.app.Activity
import com.google.android.gms.auth.api.signin.GoogleSignIn
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.embedding.android.FlutterFragment.Builder
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.auth.api.signin.GoogleSignInAccount
import com.google.android.gms.tasks.OnCompleteListener
import java.io.IOException
import android.system.Os.close
import android.graphics.Bitmap
import java.io.FileOutputStream
import java.util.UUID
import java.io.File
import java.io.OutputStream
import android.os.Environment
import androidx.core.app.NotificationCompat.getExtras
import android.os.Bundle
import android.content.Intent
import android.util.Log
import io.flutter.plugin.common.PluginRegistry


class GameCenterPlugin : MethodCallHandler {

    private final val activity: Activity

    constructor(activity: Activity) {
        this.activity = activity
    }


    companion object : PluginRegistry.ActivityResultListener {
        override fun onActivityResult(p0: Int, p1: Int, p2: Intent?): Boolean {
            Log.v("onActivityResult", "$p0 $p1")
            return true
        }

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "gamecenter")
            channel.setMethodCallHandler(GameCenterPlugin(registrar.activity()))
            registrar.addActivityResultListener(this)
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "login") {
            val silent = call.arguments as Boolean

            android.util.Log.v("Silent", silent.toString())

            val mGoogleSignInClient = GoogleSignIn.getClient(this.activity, GoogleSignInOptions.DEFAULT_GAMES_SIGN_IN);

            if (silent) {
                mGoogleSignInClient.silentSignIn().addOnCompleteListener(this.activity,
                        OnCompleteListener<GoogleSignInAccount> { task ->
                            android.util.Log.v("OnCompleteListener", task.isSuccessful.toString())
                            if (task.isSuccessful) {
                                result.success(true)
                            } else {
                                result.success(false)
                                //onDisconnected()
                            }
                        })
            } else {
                this.activity.startActivityForResult(mGoogleSignInClient.signInIntent, 9001)
            }


        } else if (call.method == "showLeaderboard") {

        } else {
            result.notImplemented()
        }
    }
}
