/// Defines the API endpoints for the application.
///
/// Provides static strings for each endpoint.
class ApiEndpoint {
  /// The endpoint for authentication.
  static final String _auth = '/auth';
  static String authLogin = '$_auth/login';
  static String authCheckStatus = '$_auth/check-status';
  static String authRegister = "$_auth/register";

  /// The endpoint for products. (Example)
  static String products = '/products';
}
