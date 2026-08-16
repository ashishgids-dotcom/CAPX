plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.capx_app"

    // ---- CRITICAL SDK REQUIREMENTS ----
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        // Modern Java toolchain compatible with AGP 8.10 / compileSdk 36
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}

    defaultConfig {
        applicationId = "com.example.capx_app"

        // Backward compatibility explicitly down to SDK 26 (Android 8.0)
        minSdk = 26
        targetSdk = 36
        versionCode = 1
        versionName = "1.0.0"

        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            // Fill these from android/key.properties before a real release build.
            // Keeping this stubbed out here on purpose - never hardcode secrets.
            storeFile = file("../keystore/release.jks")
            storePassword = System.getenv("KEYSTORE_PASSWORD") ?: ""
            keyAlias = System.getenv("KEY_ALIAS") ?: ""
            keyPassword = System.getenv("KEY_PASSWORD") ?: ""
        }
    }

    buildTypes {
        release {
            // Switch to signingConfigs.release once key.properties / env vars are set.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            isMinifyEnabled = false
            applicationIdSuffix = ".debug"
        }
    }

    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.2")
    implementation("androidx.multidex:multidex:2.0.1")
    implementation("androidx.core:core-ktx:1.13.1")
}
