pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    // Toolchain versions verified via web search as of Aug 2026.
    // IMPORTANT: AGP 9.x exists (released Jan 2026), but Flutter's own
    // release notes explicitly warn NOT to move Flutter apps to AGP 9 yet —
    // plugin compatibility with AGP 9 is still unsupported while the
    // Flutter team audits it (see flutter.dev/docs, "What's new in Flutter
    // 3.41"). So this project intentionally stays on the latest AGP 8.x
    // line (8.10.0, May 2025), which already supports compileSdk/targetSdk
    // 36. Once Flutter officially supports AGP 9, bump these two lines.
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.10" apply false
}

include(":app")
