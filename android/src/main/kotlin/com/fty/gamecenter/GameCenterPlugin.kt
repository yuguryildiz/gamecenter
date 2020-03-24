package com.fty.gamecenter

import android.app.Activity
import com.google.android.gms.auth.api.signin.GoogleSignIn
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.auth.api.signin.GoogleSignInAccount
import com.google.android.gms.tasks.OnCompleteListener
import android.content.Intent
import android.util.Log
import io.flutter.plugin.common.PluginRegistry
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.tasks.Task
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener


class GameCenterPlugin(private val registrar: Registrar) : MethodCallHandler, ActivityResultListener {

    private lateinit var result: Result

    companion object {

        private const val RC_SIGN_IN = 9001

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val plugin = GameCenterPlugin(registrar)
            registrar.addActivityResultListener(plugin)
            val channel = MethodChannel(registrar.messenger(), "gamecenter")
            channel.setMethodCallHandler(plugin)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?): Boolean {
        Log.v("onMethodCall", "addActivityResultListener")
        if (requestCode == RC_SIGN_IN) {
            if (resultCode == Activity.RESULT_OK) {
                Log.v("onActivityResult", "$requestCode $resultCode ${Activity.RESULT_OK}")
                val task: Task<GoogleSignInAccount> = GoogleSignIn.getSignedInAccountFromIntent(intent)
                try {
                    val account = task.getResult(ApiException::class.java)
                    result.success(true)

                } catch (apiException: ApiException) {
                    Log.v("ApiException", apiException.toString())
                    result.success(false)
                }
            } else {
                Log.v("onMethodCall", false.toString())
                result.success(false)
            }

        }
        return true
    }

    override fun onMethodCall(call: MethodCall, result: Result) {

        this.result = result

        if (call.method == "login") {

            val silent = call.arguments as Boolean

            val mGoogleSignInClient = GoogleSignIn.getClient(this.registrar.activity(), GoogleSignInOptions.Builder(
                GoogleSignInOptions.DEFAULT_GAMES_SIGN_IN).build()
            )

            if (silent) {
                mGoogleSignInClient.silentSignIn().addOnCompleteListener(this.registrar.activity(),
                        OnCompleteListener<GoogleSignInAccount> { task ->
                            android.util.Log.v("OnCompleteListener", task.isSuccessful.toString())
                            if (task.isSuccessful) {
                                result.success(true)
                            } else {
                                result.success(task.exception)
                                result.success(task.exception!!.message)
                                //onDisconnected()
                            }
                        })
            } else {
                this.registrar.activity().startActivityForResult(mGoogleSignInClient.signInIntent, RC_SIGN_IN)
            }


        } else if (call.method == "showLeaderboard") {

        } else {
            result.notImplemented()
        }
    }
}
