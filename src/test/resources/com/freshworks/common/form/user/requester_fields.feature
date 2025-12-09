Feature: Requester form update
  Reusable feature for updating a requester form

  Background:
    * url baseUrl
    * def username = 'fs.test12@gmail.com'
    * def password = 'freshservice321'
    * callonce read('classpath:com/freshworks/common/bootstrap-auth.feature')
    * cookie _itildesk_session = sessionCookie

  Scenario: Update form
    Given path 'admin', 'user_fields'
    And form field _method = 'put'
    And form field authenticity_token = csrfToken
    And form field jsonData = karate.toString(payload)

    When method post
    Then status 200