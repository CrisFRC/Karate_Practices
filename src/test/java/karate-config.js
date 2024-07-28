function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/',
    chanel: 'SVN'
  }
  if (env == 'dev') {
    config.userEmail = 'karate@testcr.com'
    config.userPassword = 'karate123'
  } else if (env == 'qa') {
        config.userEmail = 'karate2@test.com'
        config.userPassword = 'karate456'
  }
  var accessToken = karate.callSingle('classpath:/helpers/get_token.feature',config).authToken
  karate.configure('headers', {Authorization:'Token ' + accessToken})
  return config;
}