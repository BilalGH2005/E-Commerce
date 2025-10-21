import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @chooseProducts.
  ///
  /// In en, this message translates to:
  /// **'Choose Products'**
  String get chooseProducts;

  /// No description provided for @chooseProductsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Browse a wide range of products and find exactly what you need. From essentials to exclusive items, we\'ve got it all at your fingertips.'**
  String get chooseProductsSubtitle;

  /// No description provided for @makePayments.
  ///
  /// In en, this message translates to:
  /// **'Make Payments'**
  String get makePayments;

  /// No description provided for @makePaymentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Experience hassle-free payments with our secure and fast checkout process. Choose your preferred payment method and complete your purchase with confidence.'**
  String get makePaymentsSubtitle;

  /// No description provided for @getYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Get Your Order'**
  String get getYourOrder;

  /// No description provided for @getYourOrderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sit back and relax while we bring your order to your doorstep. Track your package in real-time and enjoy quick, reliable delivery.'**
  String get getYourOrderSubtitle;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @prev.
  ///
  /// In en, this message translates to:
  /// **'Prev'**
  String get prev;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome\nBack!'**
  String get welcomeBack;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @youWantAuthentic.
  ///
  /// In en, this message translates to:
  /// **'You want Authentic, here you go!'**
  String get youWantAuthentic;

  /// No description provided for @findItHereBuyItNow.
  ///
  /// In en, this message translates to:
  /// **'Find it here, buy it now!'**
  String get findItHereBuyItNow;

  /// No description provided for @eCommerce.
  ///
  /// In en, this message translates to:
  /// **'E-Commerce'**
  String get eCommerce;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot\npassword?'**
  String get forgotPasswordTitle;

  /// No description provided for @enterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterYourEmailAddress;

  /// No description provided for @passwordResetMessage.
  ///
  /// In en, this message translates to:
  /// **'We will send you a message to set or reset your new password'**
  String get passwordResetMessage;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @createAnAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create an\naccount'**
  String get createAnAccountTitle;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'By clicking the Create Account button, you agree to '**
  String get termsAgreement;

  /// No description provided for @ourTerms.
  ///
  /// In en, this message translates to:
  /// **'our terms'**
  String get ourTerms;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get alreadyHaveAnAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @termsText.
  ///
  /// In en, this message translates to:
  /// **'Welcome to **Stylish!**\n\nBy accessing or using our services, you agree to comply with and be bound by the following terms and conditions:\n\n1. **Account Registration**:\n   - You must provide accurate and complete information during registration.\n   - You are responsible for maintaining the confidentiality of your account credentials.\n\n2. **Product Listings**:\n   - We strive to ensure accurate product descriptions. However, we do not guarantee that product descriptions are error-free.\n\n3. **Orders and Payments**:\n   - All orders are subject to acceptance and availability.\n   - Payments must be made through authorized methods. Unauthorized payments will not be processed.\n\n4. **Returns and Refunds**:\n   - Our return and refund policy is available on the app. Please review it before making a purchase.\n\n5. **Prohibited Activities**:\n   - You may not use the app for fraudulent activities, spamming, or any unlawful purposes.\n\n6. **Privacy Policy**:\n   - Your personal data is processed according to our Privacy Policy, available on the app.\n\n7. **Liability Limitation**:\n   - **Stylish** is not responsible for any indirect, incidental, or consequential damages arising from your use of our services.\n\nThank you for using **Stylish!**'**
  String get termsText;

  /// No description provided for @addNewProduct.
  ///
  /// In en, this message translates to:
  /// **'Add New\nProduct'**
  String get addNewProduct;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @imageUrl.
  ///
  /// In en, this message translates to:
  /// **'Image URL'**
  String get imageUrl;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordLength;

  /// No description provided for @passwordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get passwordUppercase;

  /// No description provided for @passwordLowercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get passwordLowercase;

  /// No description provided for @passwordNumber.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number'**
  String get passwordNumber;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email address is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @checkEmailForVerification.
  ///
  /// In en, this message translates to:
  /// **'Check your email for verification.'**
  String get checkEmailForVerification;

  /// No description provided for @resetPasswordEmailSent.
  ///
  /// In en, this message translates to:
  /// **'If this email is registered, you will receive a reset link.'**
  String get resetPasswordEmailSent;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @priceRequired.
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get priceRequired;

  /// No description provided for @imageUrlRequired.
  ///
  /// In en, this message translates to:
  /// **'Image URL is required'**
  String get imageUrlRequired;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @switchAppTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch app theme'**
  String get switchAppTheme;

  /// No description provided for @chooseAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose app language:'**
  String get chooseAppLanguage;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'- Or continue with -'**
  String get orContinueWith;

  /// No description provided for @appleAccountsSoon.
  ///
  /// In en, this message translates to:
  /// **'Apple accounts will be supported soon.'**
  String get appleAccountsSoon;

  /// No description provided for @facebookAccountsSoon.
  ///
  /// In en, this message translates to:
  /// **'Facebook accounts will be supported soon.'**
  String get facebookAccountsSoon;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @buyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy now'**
  String get buyNow;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @googleOAuth.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get googleOAuth;

  /// No description provided for @appleOAuth.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get appleOAuth;

  /// No description provided for @facebookOAuth.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get facebookOAuth;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @yourCartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartIsEmpty;

  /// No description provided for @newProduct.
  ///
  /// In en, this message translates to:
  /// **'NEW!'**
  String get newProduct;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @signedInSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Signed in successfully'**
  String get signedInSuccessfully;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No matching products found'**
  String get noProductsFound;

  /// No description provided for @searchForProducts.
  ///
  /// In en, this message translates to:
  /// **'Search for products'**
  String get searchForProducts;

  /// No description provided for @chooseAnImage.
  ///
  /// In en, this message translates to:
  /// **'Choose an image...'**
  String get chooseAnImage;

  /// No description provided for @justIn.
  ///
  /// In en, this message translates to:
  /// **'Just In'**
  String get justIn;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'{code, select, userAlreadyExists{User already registered} userDoesNotExist{User doesn\'t exist, please sign up first} invalidLoginCredentials{Invalid login credentials} cantUseOldPassword{Can\'t use old password} tooManyRequests{Too many requests} emailNotConfirmed{Email not confirmed} other{Something went wrong}}'**
  String authError(String code);

  /// No description provided for @passwordHasBeenResetSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password has been reset successfully'**
  String get passwordHasBeenResetSuccessfully;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get seeMore;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price range'**
  String get priceRange;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @deliveryIn.
  ///
  /// In en, this message translates to:
  /// **'Delivery in'**
  String get deliveryIn;

  /// No description provided for @withinOneDay.
  ///
  /// In en, this message translates to:
  /// **'Within One Day!'**
  String get withinOneDay;

  /// No description provided for @similarItems.
  ///
  /// In en, this message translates to:
  /// **'Similar Items'**
  String get similarItems;

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'APPLIED'**
  String get applied;

  /// No description provided for @shopByCategories.
  ///
  /// In en, this message translates to:
  /// **'Shop\nby Categories'**
  String get shopByCategories;

  /// No description provided for @collection.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collection;

  /// No description provided for @bestSeller.
  ///
  /// In en, this message translates to:
  /// **'Best Seller'**
  String get bestSeller;

  /// No description provided for @welcomeToStylish.
  ///
  /// In en, this message translates to:
  /// **'Hello,'**
  String get welcomeToStylish;

  /// No description provided for @homeHeadlineText.
  ///
  /// In en, this message translates to:
  /// **'Discover the trends that define you.\nFind your perfect outfit, every day.\nShop, style, and shine with confidence.'**
  String get homeHeadlineText;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
