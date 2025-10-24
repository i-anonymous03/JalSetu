buildscript {
    // Define variables using Kotlin syntax
    val kotlin_version = "1.9.23" // From your error log

    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Use Kotlin-script syntax (parentheses, not quotes)
        classpath("com.android.tools.build:gradle:8.2.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")
        classpath("com.google.gms:google-services:4.4.1")
    }
}

plugins {
    // These plugins are applied in the app-level gradle file, so set to false here
    id("com.android.application") apply false
    id("org.jetbrains.kotlin.android") apply false
    id("dev.flutter.flutter-gradle-plugin") apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = file("build")
subprojects {
    project.buildDir = File(rootProject.buildDir, project.name)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}

