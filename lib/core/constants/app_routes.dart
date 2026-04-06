enum AppRoutes {
  temp(name: 'temp', path: '/temp'),
  home(name: 'home', path: '/'),
  onBoarding(name: 'onBoarding', path: '/onboarding'),
  auth(name: 'auth', path: '/auth'),
  forgetPassword(name: 'forgetPassword', path: '/forget_password'),
  resetPassword(name: 'resetPassword', path: '/reset_password'),
  loginCallback(name: 'loginCallback', path: '/loginCallback'),
  webview(name: 'webview', path: '/webview'),
  gettingStarted(name: 'gettingStarted', path: '/getting_started'),
  cart(name: 'cart', path: '/cart'),
  shop(name: 'shop', path: '/shop'),
  settings(name: 'settings', path: '/settings'),
  productDetails(name: 'productDetails', path: '/product_details/:product_id'),
  collection(name: 'collection', path: '/collection/:collection_id');

  const AppRoutes({required this.name, required this.path});

  final String name;
  final String path;
}
