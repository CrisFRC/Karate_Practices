Feature: Articles

  Background: Define some constants
    Given url apiUrl
    * def articleRequest = read('classpath:conduitApp/json/new_article_request.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def data = dataGenerator.getRandomArticleValues()
    * set articleRequest.article.title = data.title
    * set articleRequest.article.description = data.description
    * set articleRequest.article.body = data.body



  Scenario: create a new article

    Given path 'articles'
    And request articleRequest
    When method post
    Then status 201
    And match response.article.title == articleRequest.article.title

  Scenario:  create and delete article

    Given path 'articles'
    And request articleRequest
    When method post
    Then status 201
    * def articleId = response.article.slug
    Given path 'articles',articleId
    When method Delete
    Then status 204



