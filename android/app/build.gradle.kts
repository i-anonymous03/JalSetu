buildscript {
    ext.kotlin_version = "1.9.23"
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // FIX: Ensure the Android Gradle Plugin and Google Services versions are compatible.
        // Using stable, recent versions is crucial for FlutterFire to work correctly.
        classpath "com.android.tools.build:gradle:8.2.1"
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath "com.google.gms:google-services:4.4.1"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = "../build"
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
