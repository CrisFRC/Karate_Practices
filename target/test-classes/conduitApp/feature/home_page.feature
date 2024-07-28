@parallel=false
Feature: test for the home page

  Background: Define some constants
    * def canal = chanel
    * print canal
    Given url apiUrl


  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains  ['introduction','welcome']
    And match response.tags !contains 'truck'
    And match response.tags contains any ['ipsum','dogs','fish']
    And match response.tags == "#array"
    And match each response.tags == "#string"


  @Get-articles
  Scenario: Get 10 articles in the home page
    * params {limit:10,offset:0}
    Given path  'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response == {"articles":"#array","articlesCount":'#number'}
    And match response..bio contains null
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#string'
    And match each response..bio == '##number'
    * def idSlug = response.articles[0].slug

  Scenario: Verify all article schema response
    * def timeValidator = read('classpath:helpers/time-validator.js')
    * params {limit:10,offset:0}
    Given path  'articles'
    When method Get
    Then match each response.articles ==
    """
       {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": '#boolean'
            }
        }
    """

  Scenario: conditional logic
    * params {limit:10,offset:0}
    Given path  'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount