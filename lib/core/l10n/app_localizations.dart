import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('ru'),
    Locale('uz'),
  ];

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get systemLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @languageUzbek.
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get languageUzbek;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingStart;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Find your trusted master easily'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Description.
  ///
  /// In en, this message translates to:
  /// **'Hundreds of skilled plumbers, electricians, and other masters are in one app. Order a service at a convenient time.'**
  String get onboarding1Description;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Quality and reliable service'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Description.
  ///
  /// In en, this message translates to:
  /// **'All masters are verified and rated by customers. We guarantee quality.'**
  String get onboarding2Description;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Save time and money'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Description.
  ///
  /// In en, this message translates to:
  /// **'Agreed prices and fast service. Stop spending time searching for a master, we will find the best one for you.'**
  String get onboarding3Description;

  /// No description provided for @roleSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'How do you want to use the app?'**
  String get roleSelectionTitle;

  /// No description provided for @roleSelectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the role that fits you. You can change it later from settings.'**
  String get roleSelectionSubtitle;

  /// No description provided for @roleClientTitle.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get roleClientTitle;

  /// No description provided for @roleClientDescription.
  ///
  /// In en, this message translates to:
  /// **'For using master services, posting requests, and hiring specialists.'**
  String get roleClientDescription;

  /// No description provided for @roleMasterTitle.
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get roleMasterTitle;

  /// No description provided for @roleMasterDescription.
  ///
  /// In en, this message translates to:
  /// **'For receiving orders, providing services, and earning income.'**
  String get roleMasterDescription;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordHint;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginNoAccount;

  /// No description provided for @loginRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get loginRegister;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerTitle;

  /// No description provided for @registerEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registerEmailHint;

  /// No description provided for @registerPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get registerPasswordHint;

  /// No description provided for @registerRepeatPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get registerRepeatPasswordHint;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @registerHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerHaveAccount;

  /// No description provided for @registerLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get registerLogin;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navCreateRequestClient.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get navCreateRequestClient;

  /// No description provided for @navCreateRequestMaster.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get navCreateRequestMaster;

  /// No description provided for @navChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get navChat;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @homeRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Job requests'**
  String get homeRequestsTitle;

  /// No description provided for @homeCityName.
  ///
  /// In en, this message translates to:
  /// **'Tashkent'**
  String get homeCityName;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a master or service...'**
  String get homeSearchHint;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryPlumber.
  ///
  /// In en, this message translates to:
  /// **'Plumber'**
  String get categoryPlumber;

  /// No description provided for @categoryElectrician.
  ///
  /// In en, this message translates to:
  /// **'Electrician'**
  String get categoryElectrician;

  /// No description provided for @categoryCleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get categoryCleaning;

  /// No description provided for @categoryFurniture.
  ///
  /// In en, this message translates to:
  /// **'Furniture master'**
  String get categoryFurniture;

  /// No description provided for @chatListTitle.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chatListTitle;

  /// No description provided for @chatWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get chatWarningTitle;

  /// No description provided for @chatWarningBody.
  ///
  /// In en, this message translates to:
  /// **'Please describe the service in detail in your first message. You can send up to {maxCount} messages before the master accepts the request.'**
  String chatWarningBody(Object maxCount);

  /// No description provided for @chatBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Message input blocked. Wait for the master response.'**
  String get chatBlockedTitle;

  /// No description provided for @chatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Write a message...'**
  String get chatInputHint;

  /// No description provided for @chatMaxMessagesError.
  ///
  /// In en, this message translates to:
  /// **'You have reached the maximum number of messages. Wait for the master to accept.'**
  String get chatMaxMessagesError;

  /// No description provided for @chatContactError.
  ///
  /// In en, this message translates to:
  /// **'Sending phone numbers or links is not allowed.'**
  String get chatContactError;

  /// No description provided for @chatAcceptTestButton.
  ///
  /// In en, this message translates to:
  /// **'Master: Accept request (TEST BUTTON)'**
  String get chatAcceptTestButton;

  /// No description provided for @chatAcceptedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your request has been accepted! You can continue the conversation.'**
  String get chatAcceptedMessage;

  /// No description provided for @chatSampleMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, what service do you need?'**
  String get chatSampleMessage;

  /// No description provided for @chatBlockedInputHint.
  ///
  /// In en, this message translates to:
  /// **'Message input is blocked...'**
  String get chatBlockedInputHint;

  /// No description provided for @chatListEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No chats yet'**
  String get chatListEmptyTitle;

  /// No description provided for @chatListEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start a conversation with a master and your chats will appear here.'**
  String get chatListEmptySubtitle;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @stateLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading data'**
  String get stateLoadingTitle;

  /// No description provided for @stateLoadingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we prepare the content.'**
  String get stateLoadingSubtitle;

  /// No description provided for @stateEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get stateEmptyTitle;

  /// No description provided for @stateEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'This section is empty for now.'**
  String get stateEmptySubtitle;

  /// No description provided for @stateErrorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while loading the data.'**
  String get stateErrorSubtitle;

  /// No description provided for @homeMasterAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Master profile'**
  String get homeMasterAppBarTitle;

  /// No description provided for @homeMasterBusy.
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get homeMasterBusy;

  /// No description provided for @homeMasterFree.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get homeMasterFree;

  /// No description provided for @homeMasterAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About the specialist'**
  String get homeMasterAboutTitle;

  /// No description provided for @homeMasterPortfolioTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed work'**
  String get homeMasterPortfolioTitle;

  /// No description provided for @homeMasterPortfolioEmpty.
  ///
  /// In en, this message translates to:
  /// **'No work has been added to the portfolio yet.'**
  String get homeMasterPortfolioEmpty;

  /// No description provided for @homeMasterAgeSuffix.
  ///
  /// In en, this message translates to:
  /// **'years old'**
  String get homeMasterAgeSuffix;

  /// No description provided for @homeMasterExperienceSuffix.
  ///
  /// In en, this message translates to:
  /// **'years of experience'**
  String get homeMasterExperienceSuffix;

  /// No description provided for @homeMasterPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Service price (estimated)'**
  String get homeMasterPriceLabel;

  /// No description provided for @homeMasterChatButton.
  ///
  /// In en, this message translates to:
  /// **'Write a message'**
  String get homeMasterChatButton;

  /// No description provided for @homeMasterRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get homeMasterRatingLabel;

  /// No description provided for @homeMasterCompletedJobsLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed jobs'**
  String get homeMasterCompletedJobsLabel;

  /// No description provided for @homeMasterAboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Provides quality service in homes, offices, and commercial spaces.'**
  String get homeMasterAboutDescription;

  /// No description provided for @homeMasterPortfolioItemOneDescription.
  ///
  /// In en, this message translates to:
  /// **'Bathroom pipes were fully replaced.'**
  String get homeMasterPortfolioItemOneDescription;

  /// No description provided for @homeMasterPortfolioItemTwoDescription.
  ///
  /// In en, this message translates to:
  /// **'Electrical panel modernization completed.'**
  String get homeMasterPortfolioItemTwoDescription;

  /// No description provided for @homeJobRequestOneTitle.
  ///
  /// In en, this message translates to:
  /// **'The faucet needs to be replaced'**
  String get homeJobRequestOneTitle;

  /// No description provided for @homeJobRequestOneDescription.
  ///
  /// In en, this message translates to:
  /// **'The kitchen faucet is faulty and dripping water. A new faucet is already available, it needs to be installed.'**
  String get homeJobRequestOneDescription;

  /// No description provided for @homeJobRequestOneTimeAgo.
  ///
  /// In en, this message translates to:
  /// **'12 minutes ago'**
  String get homeJobRequestOneTimeAgo;

  /// No description provided for @homeJobRequestTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'The socket is not working'**
  String get homeJobRequestTwoTitle;

  /// No description provided for @homeJobRequestTwoDescription.
  ///
  /// In en, this message translates to:
  /// **'Two sockets in the living room are not getting power. If possible, please come and check today.'**
  String get homeJobRequestTwoDescription;

  /// No description provided for @homeJobRequestTwoTimeAgo.
  ///
  /// In en, this message translates to:
  /// **'37 minutes ago'**
  String get homeJobRequestTwoTimeAgo;

  /// No description provided for @chatPreviewOneMessage.
  ///
  /// In en, this message translates to:
  /// **'The service price will be 150,000 UZS.'**
  String get chatPreviewOneMessage;

  /// No description provided for @chatPreviewTwoMessage.
  ///
  /// In en, this message translates to:
  /// **'I am busy now, I will come in 2 hours.'**
  String get chatPreviewTwoMessage;

  /// No description provided for @homeRequestDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Job details'**
  String get homeRequestDetailTitle;

  /// No description provided for @homeRequestCustomerLabel.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get homeRequestCustomerLabel;

  /// No description provided for @homeRequestImagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get homeRequestImagesTitle;

  /// No description provided for @homeRequestBidButton.
  ///
  /// In en, this message translates to:
  /// **'Send offer'**
  String get homeRequestBidButton;

  /// No description provided for @homeRequestBidSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Send offer'**
  String get homeRequestBidSheetTitle;

  /// No description provided for @homeRequestBidPriceHint.
  ///
  /// In en, this message translates to:
  /// **'Offer price (UZS)'**
  String get homeRequestBidPriceHint;

  /// No description provided for @homeRequestBidCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Write a short note...'**
  String get homeRequestBidCommentHint;

  /// No description provided for @homeRequestBidSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get homeRequestBidSend;

  /// No description provided for @profileSectionMainTitle.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get profileSectionMainTitle;

  /// No description provided for @profileSectionSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSectionSettingsTitle;

  /// No description provided for @profileSectionAdditionalTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional'**
  String get profileSectionAdditionalTitle;

  /// No description provided for @profileOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get profileOrdersTitle;

  /// No description provided for @myOrdersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get myOrdersEmptyTitle;

  /// No description provided for @myOrdersEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your completed and active orders will appear here.'**
  String get myOrdersEmptySubtitle;

  /// No description provided for @myOrdersActiveSection.
  ///
  /// In en, this message translates to:
  /// **'Active orders'**
  String get myOrdersActiveSection;

  /// No description provided for @myOrdersCompletedSection.
  ///
  /// In en, this message translates to:
  /// **'Completed orders'**
  String get myOrdersCompletedSection;

  /// No description provided for @myOrdersMasterLabel.
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get myOrdersMasterLabel;

  /// No description provided for @myOrdersPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get myOrdersPriceLabel;

  /// No description provided for @myOrdersChatLabel.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get myOrdersChatLabel;

  /// No description provided for @myOrdersReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get myOrdersReviewTitle;

  /// No description provided for @myOrdersReviewEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit review'**
  String get myOrdersReviewEdit;

  /// No description provided for @myOrdersReviewWrite.
  ///
  /// In en, this message translates to:
  /// **'Write review'**
  String get myOrdersReviewWrite;

  /// No description provided for @myOrdersReviewPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Share your experience with this master...'**
  String get myOrdersReviewPlaceholder;

  /// No description provided for @myOrdersYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Your order'**
  String get myOrdersYourOrder;

  /// No description provided for @myOrdersCompletedOn.
  ///
  /// In en, this message translates to:
  /// **'Completed on'**
  String get myOrdersCompletedOn;

  /// No description provided for @myOrdersDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get myOrdersDateLabel;

  /// No description provided for @myOrdersStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get myOrdersStatusCompleted;

  /// No description provided for @myOrdersStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get myOrdersStatusInProgress;

  /// No description provided for @myOrdersServiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get myOrdersServiceLabel;

  /// No description provided for @myOrdersLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get myOrdersLocationLabel;

  /// No description provided for @myOrdersNoReviewText.
  ///
  /// In en, this message translates to:
  /// **'No review yet. Add your feedback after the job is completed.'**
  String get myOrdersNoReviewText;

  /// No description provided for @myOrdersSaveReview.
  ///
  /// In en, this message translates to:
  /// **'Save review'**
  String get myOrdersSaveReview;

  /// No description provided for @myOrdersCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get myOrdersCancel;

  /// No description provided for @profileSavedMastersTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved masters'**
  String get profileSavedMastersTitle;

  /// No description provided for @profilePaymentMethodsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get profilePaymentMethodsTitle;

  /// No description provided for @profileAvailabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get profileAvailabilityTitle;

  /// No description provided for @profileThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get profileThemeTitle;

  /// No description provided for @profileSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support center'**
  String get profileSupportTitle;

  /// No description provided for @profilePrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy and terms'**
  String get profilePrivacyTitle;

  /// No description provided for @profileLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogoutTitle;

  /// No description provided for @profileVersionPrefix.
  ///
  /// In en, this message translates to:
  /// **'Sayyor App v'**
  String get profileVersionPrefix;

  /// No description provided for @profileEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEditButton;
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
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
