enum Environment { DEV, UAT, PROD }

class Env {
  static Map<String, dynamic> _config;
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.devConstants;
        break;
      case Environment.UAT:
        _config = _Config.uatConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get BASE_URL {
    return _config[_Config.BASE_URL];
  }

}

class _Config {
  static const BASE_URL = 'BASE_URL';
  static const ENV = "ENV";

  static Map<String, dynamic> devConstants = {
    BASE_URL: "https://api.coindcx.com",
  };

  static Map<String, dynamic> prodConstants = {
    BASE_URL: "https://api.coindcx.com",
  };

  static Map<String, dynamic> uatConstants = {
    BASE_URL: "https://api.coindcx.com",
  };
}
