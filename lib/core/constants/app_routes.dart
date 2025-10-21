enum AppRoutes {
  temp(name: 'temp', path: '/temp'),
  home(name: 'home', path: '/'),
  onBoarding(name: 'onBoarding', path: '/onboarding'),
  auth(name: 'auth', path: '/auth'),
  forgetPassword(name: 'forgetPassword', path: '/forget_password'),
  resetPassword(name: 'resetPassword', path: '/reset_password'),
  terms(name: 'terms', path: '/terms'),
  gettingStarted(name: 'gettingStarted', path: '/getting_started'),
  cart(name: 'cart', path: '/cart'),
  shop(name: 'shop', path: '/shop'),
  profile(name: 'profile', path: '/profile'),
  settings(name: 'settings', path: '/settings'),
  productDetails(name: 'productDetails', path: '/product_details/:product_id'),
  collection(name: 'collection', path: '/collection/:collection_id');

  const AppRoutes({required this.name, required this.path});

  final String name;
  final String path;
}
