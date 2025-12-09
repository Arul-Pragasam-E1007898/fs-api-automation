Feature: Bootstrap Authentication
  Reusable feature for getting session cookie and CSRF token

  Background:
    * url baseUrl
    # Java utility for generating Basic Auth header
    * def AuthUtils = Java.type('com.freshworks.util.auth.AuthUtils')

  Scenario: Get bootstrap authentication tokens
    Given path 'api', '_', 'bootstrap'
    And def authHeader = AuthUtils.generateBasicAuth(username, password)
    And header Authorization = authHeader
    When method get
    Then status 200
    # Extract the _itildesk_session cookie from response
    And def sessionCookie = responseCookies['_itildesk_session'].value
    # Extract csrf_token from response
    And def csrfToken = response.csrf_token

