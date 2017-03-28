import Ember from 'ember';
// app/routes/application.js
import ApplicationRouteMixin from 'ember-simple-auth-auth0/mixins/application-route-mixin';

export default Ember.Route.extend(ApplicationRouteMixin , {
  intl: Ember.inject.service(),
  routeAfterAuthentication: 'login',
  beforeModel() {
    // define the app's runtime locale
    // For example, here you would maybe do an API lookup to resolver
    // which locale the user should be targeted and perhaps lazily
    // load translations using XHR and calling intl's `addTranslation`/`addTranslations`
    // method with the results of the XHR request

    // whatever you do to pick a locale for the user:
    return this.get('intl').setLocale(calculateLocale());

    // OR for those that sideload, an array is accepted to handle fallback lookups

    // en-ca is the primary locale, en-us is the fallback.
    // this is optional, and likely unnecessary if you define baseLocale (see below)
    // The primary usecase is if you side load all translations
    //
    // return this.get('intl').setLocale(['en-ca', 'en-us']);
  },
  actions: {
    login (afterLoginRoute) {
      const lang = this.get('intl').get('locale')[0];
      // Check out the docs for all the options:
      // https://auth0.com/docs/libraries/lock/customization
      const lockOptions = {
        theme: {
          logo:  'https://rundfunk-mitbestimmen.de/assets/images/logo.png'
        },
        language: lang,
        auth: {
          autoclose: true,
          redirect: false,
          responseType: 'token',
          redirectUrl: window.location.href,
          params: {
            state: (afterLoginRoute || this.get('router.url')),
            scope: 'openid email',
          }
        }
      };

      this.get('session').authenticate('authenticator:auth0-lock', lockOptions);
    },

    logout () {
      this.get('session').invalidate();
    }
  }
});

function calculateLocale(){
  const locale = navigator.language || navigator.userLanguage || 'de';
  const lang = locale.split('-')[0];
  return lang;
}
