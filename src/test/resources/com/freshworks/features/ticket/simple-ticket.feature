Feature: Ticket API Tests
  Testing ticket CRUD endpoints

  Background:
    * url baseUrl
    * callonce read('classpath:com/freshworks/common/bootstrap-auth.feature') { username: 'fs.test12@gmail.com', password: 'freshservice321' }

  Scenario: Create a ticket
    Given path 'api', '_', 'tickets'
    # Add the session cookie to subsequent requests (only if bootstrap was run)
    * cookie _itildesk_session = sessionCookie
    * header x-csrf-token = csrfToken
    # Read payload from JSON file
    And def ticketPayload = read('classpath:com/freshworks/payloads/ticket.json')
    And request ticketPayload
    When method post
    Then status 201

  Scenario: Create a ticket - payload validations - missing subject
    Given path 'api', '_', 'tickets'
    # Add the session cookie to subsequent requests (only if bootstrap was run)
    * cookie _itildesk_session = sessionCookie
    * header x-csrf-token = csrfToken
    # Read payload from JSON file
    * def ticketPayload = read('classpath:com/freshworks/payloads/ticket.json')
    * ticketPayload.subject = null
    And request ticketPayload
    When method post
    Then status 400
    And match response.description == 'Validation failed'
    And match response.errors[0].field == 'subject'
    And match response.errors[0].message == 'The value provided is of type Null.It should be of type String'
    And match response.errors[0].code == 'datatype_mismatch'

  Scenario: Create a ticket - missing csrf token
    Given path 'api', '_', 'tickets'
    # Add the session cookie to subsequent requests (only if bootstrap was run)
    * cookie _itildesk_session = sessionCookie
    # Read payload from JSON file
    * def ticketPayload = read('classpath:com/freshworks/payloads/ticket.json')
    * ticketPayload.subject = null
    And request ticketPayload
    When method post
    Then status 403
    And match response.code == 'ActionController::InvalidAuthenticityToken'

  Scenario: Create a ticket - payload validations - missing requester
    Given path 'api', '_', 'tickets'
    # Add the session cookie to subsequent requests (only if bootstrap was run)
    * cookie _itildesk_session = sessionCookie
    * header x-csrf-token = csrfToken
    # Read payload from JSON file
    * def ticketPayload = read('classpath:com/freshworks/payloads/ticket.json')
    * ticketPayload.email = null
    And request ticketPayload
    When method post
    Then status 400
    And match response.description == 'Validation failed'
    And match response.errors[0].field == 'email'
    And match response.errors[0].message == 'One of the following is mandatory: requester_id, phone, email'
    And match response.errors[0].code == 'missing_field'


  Scenario: Delete a ticket
    Given path 'api', '_', 'tickets'
    # Add the session cookie to subsequent requests (only if bootstrap was run)
    * cookie _itildesk_session = sessionCookie
    * header x-csrf-token = csrfToken
    # Read payload from JSON file
    And def ticketPayload = read('classpath:com/freshworks/payloads/ticket.json')
    And request ticketPayload
    When method post
    Then status 201

    * def ticketId = response.ticket.id
    Given path 'api', '_', 'tickets', ticketId
    * cookie _itildesk_session = sessionCookie
    * header x-csrf-token = csrfToken
    When method delete
    Then status 204



