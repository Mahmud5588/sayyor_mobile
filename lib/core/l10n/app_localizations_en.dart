// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get profileTitle => 'Profile';

  @override
  String get systemLanguage => 'System language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageUzbek => 'Uzbek';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingStart => 'Get Started';

  @override
  String get onboarding1Title => 'Find your trusted master easily';

  @override
  String get onboarding1Description =>
      'Hundreds of skilled plumbers, electricians, and other masters are in one app. Order a service at a convenient time.';

  @override
  String get onboarding2Title => 'Quality and reliable service';

  @override
  String get onboarding2Description =>
      'All masters are verified and rated by customers. We guarantee quality.';

  @override
  String get onboarding3Title => 'Save time and money';

  @override
  String get onboarding3Description =>
      'Agreed prices and fast service. Stop spending time searching for a master, we will find the best one for you.';

  @override
  String get roleSelectionTitle => 'How do you want to use the app?';

  @override
  String get roleSelectionSubtitle =>
      'Choose the role that fits you. You can change it later from settings.';

  @override
  String get roleClientTitle => 'Client';

  @override
  String get roleClientDescription =>
      'For using master services, posting requests, and hiring specialists.';

  @override
  String get roleMasterTitle => 'Master';

  @override
  String get roleMasterDescription =>
      'For receiving orders, providing services, and earning income.';

  @override
  String get continueButton => 'Continue';

  @override
  String get loginTitle => 'Login';

  @override
  String get loginEmailHint => 'Email';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginRegister => 'Register';

  @override
  String get registerTitle => 'Register';

  @override
  String get registerEmailHint => 'Email';

  @override
  String get registerPasswordHint => 'New password';

  @override
  String get registerRepeatPasswordHint => 'Repeat password';

  @override
  String get registerButton => 'Register';

  @override
  String get registerHaveAccount => 'Already have an account?';

  @override
  String get registerLogin => 'Login';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get navCreateRequestClient => 'Post';

  @override
  String get navCreateRequestMaster => 'Portfolio';

  @override
  String get navChat => 'Chat';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeRequestsTitle => 'Job requests';

  @override
  String get homeCityName => 'Tashkent';

  @override
  String get homeSearchHint => 'Search for a master or service...';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryPlumber => 'Plumber';

  @override
  String get categoryElectrician => 'Electrician';

  @override
  String get categoryCleaning => 'Cleaning';

  @override
  String get categoryFurniture => 'Furniture master';

  @override
  String get chatListTitle => 'Chats';

  @override
  String get chatWarningTitle => 'Warning';

  @override
  String chatWarningBody(Object maxCount) {
    return 'Please describe the service in detail in your first message. You can send up to $maxCount messages before the master accepts the request.';
  }

  @override
  String get chatBlockedTitle =>
      'Message input blocked. Wait for the master response.';

  @override
  String get chatInputHint => 'Write a message...';

  @override
  String get chatMaxMessagesError =>
      'You have reached the maximum number of messages. Wait for the master to accept.';

  @override
  String get chatContactError =>
      'Sending phone numbers or links is not allowed.';

  @override
  String get chatAcceptTestButton => 'Master: Accept request (TEST BUTTON)';

  @override
  String get chatAcceptedMessage =>
      'Your request has been accepted! You can continue the conversation.';

  @override
  String get chatSampleMessage => 'Hello, what service do you need?';

  @override
  String get chatBlockedInputHint => 'Message input is blocked...';

  @override
  String get chatListEmptyTitle => 'No chats yet';

  @override
  String get chatListEmptySubtitle =>
      'Start a conversation with a master and your chats will appear here.';

  @override
  String get errorTitle => 'Error';

  @override
  String get okButton => 'OK';

  @override
  String get retryButton => 'Retry';

  @override
  String get stateLoadingTitle => 'Loading data';

  @override
  String get stateLoadingSubtitle =>
      'Please wait while we prepare the content.';

  @override
  String get stateEmptyTitle => 'Nothing here yet';

  @override
  String get stateEmptySubtitle => 'This section is empty for now.';

  @override
  String get stateErrorSubtitle =>
      'Something went wrong while loading the data.';

  @override
  String get homeMasterAppBarTitle => 'Master profile';

  @override
  String get homeMasterBusy => 'Busy';

  @override
  String get homeMasterFree => 'Available';

  @override
  String get homeMasterAboutTitle => 'About the specialist';

  @override
  String get homeMasterPortfolioTitle => 'Completed work';

  @override
  String get homeMasterPortfolioEmpty =>
      'No work has been added to the portfolio yet.';

  @override
  String get homeMasterAgeSuffix => 'years old';

  @override
  String get homeMasterExperienceSuffix => 'years of experience';

  @override
  String get homeMasterPriceLabel => 'Service price (estimated)';

  @override
  String get homeMasterChatButton => 'Write a message';

  @override
  String get homeMasterRatingLabel => 'Rating';

  @override
  String get homeMasterCompletedJobsLabel => 'Completed jobs';

  @override
  String get homeMasterAboutDescription =>
      'Provides quality service in homes, offices, and commercial spaces.';

  @override
  String get homeMasterPortfolioItemOneDescription =>
      'Bathroom pipes were fully replaced.';

  @override
  String get homeMasterPortfolioItemTwoDescription =>
      'Electrical panel modernization completed.';

  @override
  String get homeJobRequestOneTitle => 'The faucet needs to be replaced';

  @override
  String get homeJobRequestOneDescription =>
      'The kitchen faucet is faulty and dripping water. A new faucet is already available, it needs to be installed.';

  @override
  String get homeJobRequestOneTimeAgo => '12 minutes ago';

  @override
  String get homeJobRequestTwoTitle => 'The socket is not working';

  @override
  String get homeJobRequestTwoDescription =>
      'Two sockets in the living room are not getting power. If possible, please come and check today.';

  @override
  String get homeJobRequestTwoTimeAgo => '37 minutes ago';

  @override
  String get chatPreviewOneMessage => 'The service price will be 150,000 UZS.';

  @override
  String get chatPreviewTwoMessage => 'I am busy now, I will come in 2 hours.';

  @override
  String get homeRequestDetailTitle => 'Job details';

  @override
  String get homeRequestCustomerLabel => 'Client';

  @override
  String get homeRequestImagesTitle => 'Images';

  @override
  String get homeRequestBidButton => 'Send offer';

  @override
  String get homeRequestBidSheetTitle => 'Send offer';

  @override
  String get homeRequestBidPriceHint => 'Offer price (UZS)';

  @override
  String get homeRequestBidCommentHint => 'Write a short note...';

  @override
  String get homeRequestBidSend => 'Send';

  @override
  String get profileSectionMainTitle => 'Main';

  @override
  String get profileSectionSettingsTitle => 'Settings';

  @override
  String get profileSectionAdditionalTitle => 'Additional';

  @override
  String get profileOrdersTitle => 'My orders';

  @override
  String get myOrdersEmptyTitle => 'No orders yet';

  @override
  String get myOrdersEmptySubtitle =>
      'Your completed and active orders will appear here.';

  @override
  String get myOrdersActiveSection => 'Active orders';

  @override
  String get myOrdersCompletedSection => 'Completed orders';

  @override
  String get myOrdersMasterLabel => 'Master';

  @override
  String get myOrdersPriceLabel => 'Price';

  @override
  String get myOrdersChatLabel => 'Chat';

  @override
  String get myOrdersReviewTitle => 'Review';

  @override
  String get myOrdersReviewEdit => 'Edit review';

  @override
  String get myOrdersReviewWrite => 'Write review';

  @override
  String get myOrdersReviewPlaceholder =>
      'Share your experience with this master...';

  @override
  String get myOrdersYourOrder => 'Your order';

  @override
  String get myOrdersCompletedOn => 'Completed on';

  @override
  String get myOrdersDateLabel => 'Date';

  @override
  String get myOrdersStatusCompleted => 'Completed';

  @override
  String get myOrdersStatusInProgress => 'In progress';

  @override
  String get myOrdersServiceLabel => 'Service';

  @override
  String get myOrdersLocationLabel => 'Location';

  @override
  String get myOrdersNoReviewText =>
      'No review yet. Add your feedback after the job is completed.';

  @override
  String get myOrdersSaveReview => 'Save review';

  @override
  String get myOrdersCancel => 'Cancel';

  @override
  String get profileSavedMastersTitle => 'Saved masters';

  @override
  String get profilePaymentMethodsTitle => 'Payment methods';

  @override
  String get profileAvailabilityTitle => 'Availability';

  @override
  String get profileThemeTitle => 'Dark mode';

  @override
  String get profileSupportTitle => 'Support center';

  @override
  String get profilePrivacyTitle => 'Privacy policy and terms';

  @override
  String get profileLogoutTitle => 'Log out';

  @override
  String get profileVersionPrefix => 'Sayyor App v';

  @override
  String get profileEditButton => 'Edit profile';
}
