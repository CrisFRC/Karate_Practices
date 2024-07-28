Feature: Home Work

  Background:
    * url apiUrl
    * configure logPrettyResponse = true
    * configure logPrettyRequest = true
    * def favoriteResponse = read('classpath:conduitApp/json/post_favorite_response.json')
    * def myFavoriteResponse = read('classpath:conduitApp/json/get_my_favorite_articles.json')


  Scenario: Favorite articles
    * def favoriteCount = 0
  #step 1: Get articles of the global
  #step 2: Get the favorites count and slug ID for the first article, save it to variables
    * call read('home_page.feature@Get-articles')
  #step 3: Make POST request to increase favorites count for the first article
    Given path 'articles/' + idSlug + '/favorite'
    When method Post
  #step 4: Verify response schema
    Then match response == favoriteResponse
  #step 5: Verify that favorites article incremented by 1
    And match response.article.slug == idSlug
    And match response.article.favoritesCount == favoriteCount + 1
  #step 6: Get all favorites articles
    * params {favorited:karateCR,limit:10,offset:0}
    Given path  'articles'
    When method Get
  #step 7: Verify response schema
    Then match response == myFavoriteResponse
  #step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
    And match response.articles[0].slug == idSlug

  Scenario: Comment articles
  #step 1: Get articles of the global feed
  #step 2: Get the slug ID for first article and save it to variable
  #step 3: Make a GET call to 'comments' end-point to get all comments
  #step 4: Verify response schema
  #step 5: Get the count of the articles array length and save to variable
  #step 6: Make POST request to publish a new comment
  #step 7: Verify response schema that should contain posted comment text
  #step 8: Get the list of all comments for this articles one more time
  #step 9: Verify number of comments increased by 1
  #step 10: Make Delete request to delete comment
  #step 11: Get all comments again and verify number of comments decreased by 1
