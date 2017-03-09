/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'frontend',
    environment: environment,
    rootURL: '/',
    locationType: 'auto',
    contentSecurityPolicy: {
        'font-src': "'self' data: https://cdn.auth0.com",
        'style-src': "'self' 'unsafe-inline'",
        'script-src': "'self' 'unsafe-eval' 'unsafe-inline' https://cdn.auth0.com",
        'connect-src': "'self' http://localhost:* api.rundfunk-mitbestimmen.de rundfunk-mitbestimmen.eu.auth0.com"
    },
    'ember-simple-auth': {
      authorizer: 'simple-auth-authorizer:jwt'
    },
    'auth0-ember-simple-auth': {
      clientID: (process.env.AUTH0_CLIENT_ID || "3NSVbVwiVABkv6uS7vRzH0sY7mqmlzOG"),
      domain: (process.env.AUTH0_DOMAIN || "rundfunk-testing.eu.auth0.com")
    },
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
      BACKEND_URL: (process.env.API_HOST || 'http://localhost:3000'),
      authenticator: 'authenticator:custom-authenticator'
    },
    metricsAdapters: [
      {
        name: 'Piwik',
        environments: ['development', 'production'],
        config: {
          piwikUrl: 'https://piwik.rundfunk-mitbestimmen.de',
          siteId: 1
        }
      }
    ]
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'integration') {
    ENV.APP.authenticator = 'authenticator:stub-authenticator'
  }

  if (environment === 'production') {
    ENV.APP.BACKEND_URL = 'https://api.rundfunk-mitbestimmen.de/';
    ENV['auth0-ember-simple-auth'] = {
      clientID: 'JRtwcxWPTYEFnTGHQBVTGI3kl8dfIH0Q',
      domain: 'rundfunk-mitbestimmen.eu.auth0.com'
    };
  }

  return ENV;
};
