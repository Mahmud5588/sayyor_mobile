// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get profileTitle => 'Профиль';

  @override
  String get systemLanguage => 'Язык системы';

  @override
  String get languageSystem => 'Система';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageUzbek => 'Узбекский';

  @override
  String get onboardingSkip => 'Пропустить';

  @override
  String get onboardingStart => 'Начать';

  @override
  String get onboarding1Title => 'Легко найдите проверенного мастера';

  @override
  String get onboarding1Description =>
      'Сотни квалифицированных мастеров, сантехников и электриков в одном приложении. Заказывайте услугу в удобное время.';

  @override
  String get onboarding2Title => 'Качественный и надежный сервис';

  @override
  String get onboarding2Description =>
      'Все мастера проверены и оценены клиентами. Мы гарантируем качество.';

  @override
  String get onboarding3Title => 'Экономьте время и деньги';

  @override
  String get onboarding3Description =>
      'Согласованные цены и быстрый сервис. Не тратьте время на поиск мастера, мы найдем лучших для вас.';

  @override
  String get roleSelectionTitle => 'Для чего вы используете приложение?';

  @override
  String get roleSelectionSubtitle =>
      'Выберите подходящую роль. Позже ее можно изменить в настройках.';

  @override
  String get roleClientTitle => 'Клиент';

  @override
  String get roleClientDescription =>
      'Для использования услуг мастеров, создания заявок и найма специалистов.';

  @override
  String get roleMasterTitle => 'Мастер';

  @override
  String get roleMasterDescription =>
      'Для получения заказов, оказания услуг и заработка.';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get loginTitle => 'Вход';

  @override
  String get loginEmailHint => 'Email';

  @override
  String get loginPasswordHint => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get loginNoAccount => 'У вас нет аккаунта?';

  @override
  String get loginRegister => 'Регистрация';

  @override
  String get registerTitle => 'Регистрация';

  @override
  String get registerEmailHint => 'Email';

  @override
  String get registerPasswordHint => 'Новый пароль';

  @override
  String get registerRepeatPasswordHint => 'Повторите пароль';

  @override
  String get registerButton => 'Зарегистрироваться';

  @override
  String get registerHaveAccount => 'Уже есть аккаунт?';

  @override
  String get registerLogin => 'Вход';

  @override
  String get navHome => 'Главная';

  @override
  String get navSearch => 'Поиск';

  @override
  String get navCreateRequestClient => 'Объявление';

  @override
  String get navCreateRequestMaster => 'Портфолио';

  @override
  String get navChat => 'Чат';

  @override
  String get navProfile => 'Профиль';

  @override
  String get homeRequestsTitle => 'Заявки на работу';

  @override
  String get homeCityName => 'Ташкент';

  @override
  String get homeSearchHint => 'Найдите мастера или услугу...';

  @override
  String get categoryAll => 'Все';

  @override
  String get categoryPlumber => 'Сантехник';

  @override
  String get categoryElectrician => 'Электрик';

  @override
  String get categoryCleaning => 'Уборка';

  @override
  String get categoryFurniture => 'Мастер по мебели';

  @override
  String get chatListTitle => 'Чаты';

  @override
  String get chatWarningTitle => 'Предупреждение';

  @override
  String chatWarningBody(Object maxCount) {
    return 'Пожалуйста, подробно опишите услугу в первом сообщении. До принятия заявки мастером можно отправить до $maxCount сообщений.';
  }

  @override
  String get chatBlockedTitle =>
      'Ввод сообщений заблокирован. Ожидайте ответа мастера.';

  @override
  String get chatInputHint => 'Напишите сообщение...';

  @override
  String get chatMaxMessagesError =>
      'Вы достигли максимального количества сообщений. Дождитесь, пока мастер примет заявку.';

  @override
  String get chatContactError =>
      'Отправка номера телефона или ссылки запрещена.';

  @override
  String get chatAcceptTestButton => 'Мастер: Принять заявку (ТЕСТОВАЯ КНОПКА)';

  @override
  String get chatAcceptedMessage =>
      'Ваш запрос принят! Вы можете продолжить общение.';

  @override
  String get chatSampleMessage => 'Здравствуйте, какая услуга вам нужна?';

  @override
  String get chatBlockedInputHint => 'Ввод сообщений заблокирован...';

  @override
  String get chatListEmptyTitle => 'Пока нет чатов';

  @override
  String get chatListEmptySubtitle =>
      'Начните разговор с мастером, и чаты появятся здесь.';

  @override
  String get errorTitle => 'Ошибка';

  @override
  String get okButton => 'ОК';

  @override
  String get retryButton => 'Повторить';

  @override
  String get stateLoadingTitle => 'Загрузка данных';

  @override
  String get stateLoadingSubtitle => 'Подождите, пока мы подготовим контент.';

  @override
  String get stateEmptyTitle => 'Здесь пока пусто';

  @override
  String get stateEmptySubtitle => 'В этом разделе пока нет данных.';

  @override
  String get stateErrorSubtitle => 'Не удалось загрузить данные.';

  @override
  String get homeMasterAppBarTitle => 'Профиль мастера';

  @override
  String get homeMasterBusy => 'Занят';

  @override
  String get homeMasterFree => 'Свободен';

  @override
  String get homeMasterAboutTitle => 'О специалисте';

  @override
  String get homeMasterPortfolioTitle => 'Выполненные работы';

  @override
  String get homeMasterPortfolioEmpty => 'Пока в портфолио нет работ.';

  @override
  String get homeMasterAgeSuffix => 'лет';

  @override
  String get homeMasterExperienceSuffix => 'лет опыта';

  @override
  String get homeMasterPriceLabel => 'Цена услуги (примерно)';

  @override
  String get homeMasterChatButton => 'Написать сообщение';

  @override
  String get homeMasterRatingLabel => 'Рейтинг';

  @override
  String get homeMasterCompletedJobsLabel => 'Выполнено работ';

  @override
  String get homeMasterAboutDescription =>
      'Оказывает качественные услуги в домах, офисах и коммерческих помещениях.';

  @override
  String get homeMasterPortfolioItemOneDescription =>
      'Полностью заменены трубы в ванной комнате.';

  @override
  String get homeMasterPortfolioItemTwoDescription =>
      'Выполнена модернизация электрического щита.';

  @override
  String get homeJobRequestOneTitle => 'Нужно заменить кран';

  @override
  String get homeJobRequestOneDescription =>
      'Кухонный кран неисправен и капает вода. Новый кран уже есть, нужно установить.';

  @override
  String get homeJobRequestOneTimeAgo => '12 минут назад';

  @override
  String get homeJobRequestTwoTitle => 'Розетка не работает';

  @override
  String get homeJobRequestTwoDescription =>
      'Две розетки в гостиной не подают питание. Если возможно, пожалуйста, подъезжайте сегодня и проверьте.';

  @override
  String get homeJobRequestTwoTimeAgo => '37 минут назад';

  @override
  String get chatPreviewOneMessage => 'Цена услуги будет 150 000 сум.';

  @override
  String get chatPreviewTwoMessage => 'Сейчас занят, приеду через 2 часа.';

  @override
  String get homeRequestDetailTitle => 'Детали заявки';

  @override
  String get homeRequestCustomerLabel => 'Клиент';

  @override
  String get homeRequestImagesTitle => 'Изображения';

  @override
  String get homeRequestBidButton => 'Отправить предложение';

  @override
  String get homeRequestBidSheetTitle => 'Отправить предложение';

  @override
  String get homeRequestBidPriceHint => 'Цена предложения (UZS)';

  @override
  String get homeRequestBidCommentHint => 'Напишите короткий комментарий...';

  @override
  String get homeRequestBidSend => 'Отправить';

  @override
  String get profileSectionMainTitle => 'Основное';

  @override
  String get profileSectionSettingsTitle => 'Настройки';

  @override
  String get profileSectionAdditionalTitle => 'Дополнительно';

  @override
  String get profileOrdersTitle => 'Мои заказы';

  @override
  String get myOrdersEmptyTitle => 'Пока нет заказов';

  @override
  String get myOrdersEmptySubtitle =>
      'Здесь появятся ваши активные и завершенные заказы.';

  @override
  String get myOrdersActiveSection => 'Активные заказы';

  @override
  String get myOrdersCompletedSection => 'Завершенные заказы';

  @override
  String get myOrdersMasterLabel => 'Мастер';

  @override
  String get myOrdersPriceLabel => 'Цена';

  @override
  String get myOrdersChatLabel => 'Чат';

  @override
  String get myOrdersReviewTitle => 'Отзыв';

  @override
  String get myOrdersReviewEdit => 'Редактировать отзыв';

  @override
  String get myOrdersReviewWrite => 'Написать отзыв';

  @override
  String get myOrdersReviewPlaceholder =>
      'Поделитесь своим опытом с этим мастером...';

  @override
  String get myOrdersYourOrder => 'Ваш заказ';

  @override
  String get myOrdersCompletedOn => 'Завершено';

  @override
  String get myOrdersDateLabel => 'Дата';

  @override
  String get myOrdersStatusCompleted => 'Завершено';

  @override
  String get myOrdersStatusInProgress => 'В процессе';

  @override
  String get myOrdersServiceLabel => 'Услуга';

  @override
  String get myOrdersLocationLabel => 'Локация';

  @override
  String get myOrdersNoReviewText =>
      'Отзыв пока не оставлен. Добавьте его после завершения работы.';

  @override
  String get myOrdersSaveReview => 'Сохранить отзыв';

  @override
  String get myOrdersCancel => 'Отмена';

  @override
  String get profileSavedMastersTitle => 'Сохраненные мастера';

  @override
  String get profilePaymentMethodsTitle => 'Способы оплаты';

  @override
  String get profileAvailabilityTitle => 'Доступность';

  @override
  String get profileThemeTitle => 'Темная тема';

  @override
  String get profileSupportTitle => 'Центр поддержки';

  @override
  String get profilePrivacyTitle => 'Политика конфиденциальности и условия';

  @override
  String get profileLogoutTitle => 'Выйти';

  @override
  String get profileVersionPrefix => 'Sayyor App v';

  @override
  String get profileEditButton => 'Редактировать профиль';
}
