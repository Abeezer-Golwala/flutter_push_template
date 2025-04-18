package com.example.my_flutter_app
import android.util.Log
import com.clevertap.android.pushtemplates.PushTemplateNotificationHandler
import com.clevertap.android.sdk.ActivityLifecycleCallback
import com.clevertap.android.sdk.CleverTapAPI
import com.clevertap.android.sdk.CleverTapInstanceConfig
import com.clevertap.clevertap_plugin.CleverTapApplication

class MyApplication : CleverTapApplication() {
    override fun onCreate() {
        CleverTapAPI.setDebugLevel(3)
        CleverTapAPI.setNotificationHandler(PushTemplateNotificationHandler())


        ActivityLifecycleCallback.register(this)
        val clevertapAdditionalInstanceConfig: CleverTapInstanceConfig? =
                     CleverTapInstanceConfig.createInstance(
                        this,
                "TEST-86K-6R8-W66Z",
                "TEST-b26-36b"
            )
        // default is CleverTapAPI.LogLevel.INFO
        val clevertapAdditionalInstance: CleverTapAPI? =
            CleverTapAPI.instanceWithConfig(this,clevertapAdditionalInstanceConfig)

        clevertapAdditionalInstance?.getCleverTapID { id -> { Log.d("Clevertap","Additional CleverTap ID: $id")} }
        super.onCreate()
    }
}