package com.example.weather_app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews

class SimpleAppWidget : AppWidgetProvider() {
    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager,
                                appWidgetId: Int) {

        // // Construct the RemoteViews object
        // val views = RemoteViews(context.getPackageName(), R.layout.simple_app_widget)

        // // Construct an Intent object includes web adresss.
        // val intent = Intent(Intent.ACTION_VIEW, Uri.parse("https://flutter.io/"))

        // // In widget we are not allowing to use intents as usually. We have to use PendingIntent instead of 'startActivity'
        // val pendingIntent = PendingIntent.getActivity(context, 0, intent, 0)

        // // Here the basic operations the remote view can do.
        // views.setOnClickPendingIntent(R.id.tvWidget, pendingIntent)

        // // Instruct the widget manager to update the widget
        // appWidgetManager.updateAppWidget(appWidgetId, views)
    }

}