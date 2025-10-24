# JalSetu

before executing change a few settings ,
turn on (code runner:Run in terminal )


💧 JalSetu - Water Quality and Health Monitoring App
JalSetu (जलसेतु - Water Bridge) is a community-driven mobile application built with Flutter and Firebase, designed to monitor water-related health issues, report symptoms, and provide real-time alerts on water quality in local areas.

This project is the culmination of technical discussions regarding environment setup, dependency management, authentication implementation, and efficient team collaboration via Git.

🚀 Key Features
Firebase Authentication: Secure login using Email/Password and Google Sign-In.

User Status Monitoring: Implemented AuthWrapper for intelligent routing based on user login status.

Health Reporting: Allows users to anonymously report symptoms related to waterborne diseases.

Real-time Alerts: System for pushing critical water quality alerts and notifications.

Fully Responsive UI: Built with Flutter for a consistent experience on Android and iOS devices.

🛠️ Getting Started
Prerequisites
To run this project, you need:

Flutter SDK (v3.19.x or newer recommended)

Android SDK Command-Line Tools (Android Studio is not required).

Git installed and configured on your machine.

A Firebase Project: Connected with Android and iOS app configurations.

Installation
Clone the Repository:

git clone [https://github.com/i-anonymous03/JalSetu.git](https://github.com/i-anonymous03/JalSetu.git)
cd JalSetu

Install Dependencies:

flutter pub get

Configure Firebase:
Ensure you have generated the required Firebase configuration file (firebase_options.dart) by running:

flutterfire configure

(Note: This requires the Firebase CLI to be installed.)

Update App Icons (Team Use):
If the logo has been changed, regenerate the platform icons using the flutter_launcher_icons package:

flutter pub run flutter_launcher_icons

👨‍💻 Team Collaboration Guide
This project uses Git for synchronization. We have two custom Batch scripts (.bat files) to simplify the Git workflow for all team members.

1. Start Your Work
Before starting any coding, always pull the latest changes from the main branch:

Method: Double-click the start_work.bat file in the root directory.

Command (If using Terminal): git pull origin main

2. End Your Work (Commit & Push)
When you are done for the day or complete a feature, use this script to save and upload your progress:

Method: Double-click the end_work.bat file in the root directory.

Action: The script will prompt you for a short description, automatically create a commit with the current date/time, and push the changes to GitHub.

Command (If using Terminal): The script executes git add ., git commit -m "...", and git push.

📂 Project Structure (Simplified)
Folder/File

Purpose

lib/main.dart

Application entry point and MaterialApp configuration. Uses AuthWrapper as the initial screen.

lib/routes.dart

Centralized named routing map for navigation (e.g., /login, /home).

lib/src/services/

Contains core services, notably auth_wrapper.dart (handles login redirection).

lib/src/screens/

Holds all primary pages (Login, Register, Home, Alerts, etc.).

android/ & ios/

Native configurations and app icon assets.

firebase_options.dart

Auto-generated Firebase configuration.

💡 Troubleshooting Common Issues
Issue

Cause

Fix

Routing Error

If the home property is specified... redundant.

Remove the home: property from MaterialApp in main.dart. Use initialRoute: '/' instead.

Cannot Push (403)

Git using incorrect credentials (BhanuuChoudhary vs. i-anonymous03).

Generate a Personal Access Token (PAT) from the GitHub account with write access and use it as the password when pushing.

non-fast-forward

Local history behind remote (usually on first push).

Run git pull origin main --allow-unrelated-histories before pushing.

end_work.bat Read-Only

PowerShell terminal is stuck in QuickEdit mode.

Click directly in the terminal or press Esc to regain input focus before typing the description.

PowerShell Errors

Running Batch commands directly in PowerShell.

Execute the scripts using cmd /c start_work.bat or double-click the file in File Explorer.
