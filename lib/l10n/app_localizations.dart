import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'JalSetu'**
  String get appName;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInInstructions.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to JalSetu'**
  String get signInInstructions;

  /// No description provided for @emailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailPlaceholder;

  /// No description provided for @passwordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordPlaceholder;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @orDivider.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get orDivider;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @phoneSignIn.
  ///
  /// In en, this message translates to:
  /// **'Phone Sign-In'**
  String get phoneSignIn;

  /// No description provided for @enterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Phone Number'**
  String get enterPhone;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerTitle;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Your JalSetu Account'**
  String get createAccountTitle;

  /// No description provided for @joinCommunityInstruction.
  ///
  /// In en, this message translates to:
  /// **'Join the community to monitor water and health.'**
  String get joinCommunityInstruction;

  /// No description provided for @confirmPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordPlaceholder;

  /// No description provided for @iAmA.
  ///
  /// In en, this message translates to:
  /// **'I am a...'**
  String get iAmA;

  /// No description provided for @roleVillager.
  ///
  /// In en, this message translates to:
  /// **'Villager'**
  String get roleVillager;

  /// No description provided for @roleASHAWorker.
  ///
  /// In en, this message translates to:
  /// **'ASHA Worker'**
  String get roleASHAWorker;

  /// No description provided for @roleVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer / Worker'**
  String get roleVolunteer;

  /// No description provided for @roleDoctor.
  ///
  /// In en, this message translates to:
  /// **'Clinic / Doctor'**
  String get roleDoctor;

  /// No description provided for @roleDescriptionCommunity.
  ///
  /// In en, this message translates to:
  /// **'Report symptoms or check water safety.'**
  String get roleDescriptionCommunity;

  /// No description provided for @roleDescriptionVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Collect data & help the community.'**
  String get roleDescriptionVolunteer;

  /// No description provided for @roleDescriptionDoctor.
  ///
  /// In en, this message translates to:
  /// **'Monitor reports & issue alerts.'**
  String get roleDescriptionDoctor;

  /// No description provided for @whoAreYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Who are you?'**
  String get whoAreYouTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get navAlerts;

  /// No description provided for @navHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get navHealth;

  /// No description provided for @navFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get navFeedback;

  /// No description provided for @navHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get navHelp;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'JalSetu - Dashboard'**
  String get dashboardTitle;

  /// No description provided for @reportSymptomsButton.
  ///
  /// In en, this message translates to:
  /// **'Report Symptoms'**
  String get reportSymptomsButton;

  /// No description provided for @alertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get alertsTitle;

  /// No description provided for @reportSymptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Health Symptoms'**
  String get reportSymptomsTitle;

  /// No description provided for @symptomSelectPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please select the symptoms you are experiencing:'**
  String get symptomSelectPrompt;

  /// No description provided for @symptomFever.
  ///
  /// In en, this message translates to:
  /// **'Fever'**
  String get symptomFever;

  /// No description provided for @symptomDiarrhoea.
  ///
  /// In en, this message translates to:
  /// **'Diarrhoea'**
  String get symptomDiarrhoea;

  /// No description provided for @symptomVomiting.
  ///
  /// In en, this message translates to:
  /// **'Vomiting'**
  String get symptomVomiting;

  /// No description provided for @symptomStomachPain.
  ///
  /// In en, this message translates to:
  /// **'Stomach Pain / Cramps'**
  String get symptomStomachPain;

  /// No description provided for @additionalNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes (Optional)'**
  String get additionalNotesLabel;

  /// No description provided for @submitReportButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submitReportButton;

  /// No description provided for @waterHealthReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Water Health Report'**
  String get waterHealthReportTitle;

  /// No description provided for @healthAnalysisPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Detailed water health analysis will be shown here.'**
  String get healthAnalysisPlaceholder;

  /// No description provided for @feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedbackTitle;

  /// No description provided for @feedbackLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Feedback'**
  String get feedbackLabel;

  /// No description provided for @submitFeedbackButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback'**
  String get submitFeedbackButton;

  /// No description provided for @feedbackThankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your feedback!'**
  String get feedbackThankYou;

  /// No description provided for @helpSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportTitle;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqTitle;

  /// No description provided for @faqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faqSubtitle;

  /// No description provided for @contactUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsTitle;

  /// No description provided for @contactUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get in touch with our support team'**
  String get contactUsSubtitle;

  /// No description provided for @aboutUsTitle.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUsTitle;

  /// No description provided for @aboutUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn more about JalSetu'**
  String get aboutUsSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
