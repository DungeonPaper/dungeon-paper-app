import java.util.Properties

plugins {
  id("com.android.application")
  // START: FlutterFire Configuration
  id("com.google.gms.google-services")
  // END: FlutterFire Configuration
  id("kotlin-android")
  id("dev.flutter.flutter-gradle-plugin")
}

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
  localPropertiesFile.reader(Charsets.UTF_8).use { reader ->
    localProperties.load(reader)
  }
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
  keystorePropertiesFile.reader(Charsets.UTF_8).use { reader ->
    keystoreProperties.load(reader)
  }
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

android {
  namespace = "app.dungeonpaper"
  compileSdk = 35


  defaultConfig {
    applicationId = "app.dungeonpaper"
    minSdk = 23
    targetSdk = 34
    versionCode = flutterVersionCode.toInt()
    versionName = flutterVersionName
  }

  signingConfigs {
    create("release") {
      keyAlias = keystoreProperties["keyAlias"] as String
      keyPassword = keystoreProperties["keyPassword"] as String
      storeFile = keystoreProperties["storeFile"]?.let { file(it) }
      storePassword = keystoreProperties["storePassword"] as String
    }
  }

  buildTypes {
    getByName("release") {
      signingConfig = signingConfigs.getByName("release")
    }
  }

  compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
  }

  kotlinOptions {
    jvmTarget = "17"
  }
}

flutter {
  source = "../.."
}

dependencies {
  implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
}