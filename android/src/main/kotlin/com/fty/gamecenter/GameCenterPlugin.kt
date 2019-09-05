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


class GameCenterPlugin: MethodCallHandler {

  private final val activity: Activity

  constructor(activity: Activity) {
    this.activity = activity
  }


  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "gamecenter")
      channel.setMethodCallHandler(GameCenterPlugin(registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "login") {
      val mGoogleSignInClient = GoogleSignIn.getClient(this.activity, GoogleSignInOptions.DEFAULT_GAMES_SIGN_IN);

      mGoogleSignInClient.silentSignIn().addOnCompleteListener(this.activity,
              OnCompleteListener<GoogleSignInAccount> { task ->
                if (task.isSuccessful) {
                  //onConnected(task.result)
                } else {
                  //onDisconnected()
                }
              })

      result.success("Login Success")
    } else {
      result.notImplemented()
    }
  }
}
