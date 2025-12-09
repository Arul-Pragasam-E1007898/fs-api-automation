Feature: Requester Public API Tests
  Testing requester CRUD endpoints

  Background:
    * url baseUrl
    * def username = '5hQ_0PPGvN8lHppBIXqd'
    * def password = 'X'
    # Java utility for generating Basic Auth header
    * def AuthUtils = Java.type('com.freshworks.util.auth.AuthUtils')
    * def Faker = Java.type('com.freshworks.util.fake.FakeFactory')

  Scenario: Create a requester
    Given path 'api', 'v2', 'requesters'
    And def authHeader = AuthUtils.generateBasicAuth(username, password)
    And header Authorization = authHeader
    And def requesterPayload = read('classpath:com/freshworks/payloads/requesters.json')
    * requesterPayload.primary_email = Faker.newEmail()
    And request requesterPayload
    When method post
    Then status 201

  Scenario: List all requester
    Given path 'api', 'v2', 'requesters'
    And def authHeader = AuthUtils.generateBasicAuth(username, password)
    And header Authorization = authHeader
    When method get
    Then status 200

  Scenario: Deactivate requester
    Given path 'api', 'v2', 'requesters'
    And def authHeader = AuthUtils.generateBasicAuth(username, password)
    And header Authorization = authHeader
    And def requesterPayload = read('classpath:com/freshworks/payloads/requesters.json')
    * requesterPayload.primary_email = Faker.newEmail()
    And request requesterPayload
    When method post
    Then status 201

    * def requesterId = response.requester.id

    # Deactivate
    Given path 'api', 'v2', 'requesters', requesterId
    And header Authorization = authHeader
    When method delete
    Then status 204

    Given path 'api', 'v2', 'requesters', requesterId
    And header Authorization = authHeader
    When method get
    Then status 200

  Scenario: Reactivate requester
    Given path 'api', 'v2', 'requesters'
    And def authHeader = AuthUtils.generateBasicAuth(username, password)
    And header Authorization = authHeader
    And def requesterPayload = read('classpath:com/freshworks/payloads/requesters.json')
    * requesterPayload.primary_email = Faker.newEmail()
    And request requesterPayload
    When method post
    Then status 201

    * def requesterId = response.requester.id

    # Deactivate
    Given path 'api', 'v2', 'requesters', requesterId
    And header Authorization = authHeader
    When method delete
    Then status 204

    # Reactivate
    Given path 'api', 'v2', 'requesters', requesterId, 'reactivate'
    And header Authorization = authHeader
    And header content-type = 'application/json'
    When method put
    Then status 200

    Given path 'api', 'v2', 'requesters', requesterId
    And header Authorization = authHeader
    When method get
    Then status 200


  Scenario: Delete requester
    Given path 'api', 'v2', 'requesters'
    And def authHeader = AuthUtils.generateBasicAuth(username, password)
    And header Authorization = authHeader
    And def requesterPayload = read('classpath:com/freshworks/payloads/requesters.json')
    * requesterPayload.primary_email = Faker.newEmail()
    And request requesterPayload
    When method post
    Then status 201

    * def requesterId = response.requester.id

    # Deactivate
    Given path 'api', 'v2', 'requesters', requesterId
    And header Authorization = authHeader
    When method delete
    Then status 204

    # Deactivate
    Given path 'api', 'v2', 'requesters', requesterId, 'forget'
    And header Authorization = authHeader
    When method delete
    Then status 204

    Given path 'api', 'v2', 'requesters', requesterId
    And header Authorization = authHeader
    When method get
    Then status 404




