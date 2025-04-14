package com.example.my_flutter_app
import com.clevertap.android.pushtemplates.PushTemplateNotificationHandler
import com.clevertap.android.pushtemplates.TemplateRenderer
import com.clevertap.android.sdk.ActivityLifecycleCallback
import com.clevertap.clevertap_plugin.CleverTapApplication
import com.clevertap.android.sdk.CleverTapAPI

class MyApplication : CleverTapApplication() {
    override fun onCreate() {
        CleverTapAPI.setDebugLevel(3)
        CleverTapAPI.setNotificationHandler(PushTemplateNotificationHandler())
        ActivityLifecycleCallback.register(this)
        super.onCreate()
    }
}