package com.lengdev.livenessdetector

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import android.util.Log

/** LivenessDetectorPlugin */
class LivenessDetectorPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var livenessDetector: LivenessDetector? = null
    private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.leng.dev/liveness_detector")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "initialize" -> initializeSync(result)
            "detect_liveness" -> detectLivenessSync(call, result)
            "destroy" -> destroy(result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // --- Initialize detector ---
    fun initializeSync(result: Result) {
        CoroutineScope(Dispatchers.Default).launch {
            try {
                if (livenessDetector != null) {
                    livenessDetector?.destroy()
                    livenessDetector = null
                }

                livenessDetector = LivenessDetector()
                val status = livenessDetector?.loadModel(flutterPluginBinding.applicationContext.assets)

                withContext(Dispatchers.Main) {
                    if (status == 0) {
                        result.success(true)
                    } else {
                        result.error(
                            "INITIALIZATION_ERROR",
                            "Failed to initialize detector.",
                            null
                        )
                    }
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    result.error(
                        "INITIALIZATION_ERROR",
                        "Failed to initialize detector: ${e.message}",
                        null
                    )
                }
            }
        }
    }

    // --- Detect liveness ---
    fun detectLivenessSync(call: MethodCall, result: Result) {
        CoroutineScope(Dispatchers.Default).launch {
            try {
                if (livenessDetector == null) {
                    withContext(Dispatchers.Main) {
                        result.error(
                            "NO_INITIALIZE_MODULE_ERROR",
                            "Detector not yet initialized.",
                            null
                        )
                    }
                    return@launch
                }

                // Extract arguments
                val yuv = call.argument<ByteArray>("yuvBytes")
                    ?: throw IllegalArgumentException("Missing yuvBytes data")
                val previewWidth = call.argument<Int>("previewWidth") ?: 0
                val previewHeight = call.argument<Int>("previewHeight") ?: 0
                val orientation = call.argument<Int>("orientation") ?: 0
                val faceBoxMap = call.argument<Map<String, Int>>("faceBox")
                    ?: throw IllegalArgumentException("Missing face box data")

                val faceBox = FaceBox(
                    left = faceBoxMap["left"] ?: 0,
                    top = faceBoxMap["top"] ?: 0,
                    right = faceBoxMap["right"] ?: 0,
                    bottom = faceBoxMap["bottom"] ?: 0,
                    confidence = 0f
                )

                // Call native detection
                val confidenceScore = livenessDetector?.detect(
                    yuv,
                    previewWidth,
                    previewHeight,
                    orientation,
                    faceBox
                )

                withContext(Dispatchers.Main) {
                    result.success(confidenceScore)
                }

            } catch (e: Exception) {
                Log.d("LivenessDetector","Error : $e")
                withContext(Dispatchers.Main) {
                    result.error(
                        "DETECT_LIVENESS_ERROR",
                        "Failed to detect liveness: ${e.message}",
                        null
                    )
                }
            }
        }
    }

    // --- Destroy detector ---
    fun destroy(result: Result) {
        try {
            if (livenessDetector == null) {
                result.error(
                    "NO_INITIALIZE_MODULE_ERROR",
                    "Detector not yet initialized.",
                    null
                )
                return
            }
            livenessDetector?.destroy()
            livenessDetector = null
            result.success(true)
        } catch (e: Exception) {
            result.error(
                "DESTROY_DETECTOR_ERROR",
                "Failed to destroy detector: ${e.message}",
                null
            )
        }
    }
}
