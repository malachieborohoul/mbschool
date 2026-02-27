class AppSecrets {
  static const supabaseUrl = 'https://qnfuugllerhpnwftflcb.supabase.co';
  static const supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuZnV1Z2xsZXJocG53ZnRmbGNiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwOTcyNjUsImV4cCI6MjA0NjY3MzI2NX0.2ILvzCpEAvhnxaLuAokPEly_UG4vpyS2lZp1dMYFv04';
static const webClientId =
          '403048485258-dakove07d5gf4cc0uvs6vafjrsdholtt.apps.googleusercontent.com';

  static const iosClientId =
          '403048485258-udp33m5ub27vpav7dh8n8s35tfd9n0de.apps.googleusercontent.com';

  // static const baseUrl = 'https://api.wegoopay.com';
  static const baseUrl = 'http://localhost:3000/api/v1';

//   static const AUTH0_DOMAIN = "dev-ksc4vops6wh6w7mo.us.auth0.com";
//   static const AUTH0_CLIENT_ID = "FupNAKxgjgSizgDv1YbZ1nAyBSgJbc2I";
//   static const AUTH0_ISSUER = "https://${AUTH0_DOMAIN}";


  static const AUTH0_DOMAIN = "auth.wegoopay.com";
  static const AUTH0_REALM = "Wegoopay";
  static const AUTH0_CLIENT_ID = "wegoopay-mobile";
  static const AUTH0_ISSUER = "https://${AUTH0_DOMAIN}/realms/${AUTH0_REALM}";
  static const BUNDLE_IDENTIFIER = "com.bsm.wenzo";
  static const AUTH0_REDIRECT_URI = "$BUNDLE_IDENTIFIER:/login-callback";
  static const REFRESH_TOKEN_KEY = "refresh_token";
  static const ACCESS_TOKEN_KEY = "access_token";
  static const USER_TYPE_EXTERNAL = "external";
  static const USER_TYPE_INTERNAL = "internal";


  static const ERROR_NETWORK = "network";



//GATEWAYS
  static const GATEWAY_BANK = "bank";
  static const GATEWAY_STRIPE = "stripe";
  static const GATEWAY_OM = "orangemoney";
  static const GATEWAY_PAYPAL = "paypal";
  static const GATEWAY_WAVE = "wave";



//AUTH_ERRORS
static const AUTH_INVALID_CREDENTIALS = "AUTH_INVALID_CREDENTIALS";
static const AUTH_USERNAME_OR_EMAIL_ALREADY_EXISTS = "AUTH_USERNAME_OR_EMAIL_ALREADY_EXISTS";

//Withdraw_ERRORS
static const INSUFFICIENT_BALANCE = "INSUFFICIENT_BALANCE";
static const WITHDRAW_LIMIT = "WITHDRAW_LIMIT";
static const NULL_RECEIVER = "NULL_RECEIVER";
static const NEGATIVE_AMOUNT = "NEGATIVE_AMOUNT";


//CHARGE TYPE
static const CHARGE_TYPE_PERCENT="percent";
static const CHARGE_TYPE_FIXED="fixed";
}
