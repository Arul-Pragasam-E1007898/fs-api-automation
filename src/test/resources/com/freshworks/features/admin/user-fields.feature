@ignore
Feature: Update User Fields (Admin)

  Background:
    * url baseUrl
    * def username = 'fs.test12@gmail.com'
    * def password = 'freshservice321'
    * callonce read('classpath:com/freshworks/common/bootstrap-auth.feature')
    * cookie _itildesk_session = sessionCookie
    * header x-csrf-token = csrfToken

  Scenario: Update user fields via admin UI endpoint
    Given path 'admin', 'user_fields'

    # Form params (Rails-style)
    And form field utf8 = '✓'
    And form field _method = 'put'
    And form field authenticity_token = x-csrf-token

    # Load large JSON separately (BEST PRACTICE)
    And form field jsonData = read('classpath:payloads/user-fields.json')

    When method post
    Then status 200
