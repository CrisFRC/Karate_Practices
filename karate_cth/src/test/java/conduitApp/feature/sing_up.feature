Feature: Sign up new user

  Background:
    Given url apiUrl
    * def dataGenerator = Java.type('helpers.DataGenerator')

  @debug
  Scenario: New user Sign up
    * def timeValidator = read('classpath:helpers/time-validator.js')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUserName = dataGenerator.getRandomUserName()
    Given path 'users'
    And request
    """
      {
        "user": {
          "email": #(randomEmail),
          "password": "123Karate123",
          "username":#(randomUserName)
        }
      }
    """
    When method Post
    Then status 201
    And match response ==
    """
      {
          "user": {
              "email": #(randomEmail),
              "username":#(randomUserName),
              "bio": null,
              "image": "##string",
              "token": "#string"
          }
      }
    """


  Scenario Outline: Validate error message
    * def timeValidator = read('classpath:helpers/time-validator.js')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUserName = dataGenerator.getRandomUserName()
    Given path 'users'
    And request
    """
      {
        "user": {
          "email": "<email>",
          "password": "<pass>",
          "username":"<user>"
        }
      }
    """
    When method Post
    Then status 422
    And  match response == <errorResponse>
    Examples:
      | email                | pass      | user              | errorResponse                                      |
      | #(randomEmail)       | karate123 | Karate123         | {"errors":{"username":["has already been taken"]}} |
      | karateUser1@test.com | karate123 | #(randomUserName) | {"errors":{"email":["has already been taken"]}}    |