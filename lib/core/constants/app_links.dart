abstract class AppLinks {
  static const appScheme = 'stylish';
  static const resetPasswordRedirectHost = 'reset-password-callback';
  static const signUpRedirectHost = 'signup-callback';
  static const resetPasswordDeepLink =
      '$appScheme://$resetPasswordRedirectHost';
  static const signUpRedirectDeepLink = '$appScheme://$signUpRedirectHost';
  static const _termsOfServiceLinkEN =
      'https://stylish-flutter.netlify.app/terms';
  static const _privacyPolicyLinkEN =
      'https://stylish-flutter.netlify.app/privacy';
  static const _termsOfServiceLinkAR =
      'https://stylish-flutter.netlify.app/terms_ar';
  static const _privacyPolicyLinkAR =
      'https://stylish-flutter.netlify.app/privacy_ar';

  static String termsOfServiceLink(String locale) {
    if (locale == 'en') {
      return _termsOfServiceLinkEN;
    } else {
      return _termsOfServiceLinkAR;
    }
  }

  static String privacyPolicyLink(String locale) {
    if (locale == 'en') {
      return _privacyPolicyLinkEN;
    } else {
      return _privacyPolicyLinkAR;
    }
  }
}
