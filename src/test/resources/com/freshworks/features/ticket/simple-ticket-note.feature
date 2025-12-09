Feature: Ticket Note API Tests
  Testing ticket note CRUD endpoints

  Background:
    * url baseUrl
    * def username = 'fs.test12@gmail.com'
    * def password = 'freshservice321'
    * callonce read('classpath:com/freshworks/common/bootstrap-auth.feature')
    * callonce read('classpath:com/freshworks/common/ticket-create.feature')
    * def ticketId = response.ticket.id

  Scenario: Create a note to a ticket
    Given path 'api', '_', 'tickets', ticketId, 'notes'
    * header x-csrf-token = csrfToken
    And def notePayload = read('classpath:com/freshworks/payloads/note.json')
    * notePayload.body = "Note1"
    And request notePayload
    When method post
    Then status 201

  Scenario: Update note to a ticket
    Given path 'api', '_', 'tickets', ticketId, 'notes'
    * header x-csrf-token = csrfToken
    And def notePayload = read('classpath:com/freshworks/payloads/note.json')
    * notePayload.body = "Note1"
    And request notePayload
    When method post
    Then status 201

    * def noteId = response.conversation.id
    Given path 'api', '_', 'conversations', noteId
    * header x-csrf-token = csrfToken
    * notePayload.body = "Note2"
    And request notePayload
    When method put
    Then status 200

  Scenario: Delete a note from a ticket
    Given path 'api', '_', 'tickets', ticketId, 'notes'
    * header x-csrf-token = csrfToken
    And def notePayload = read('classpath:com/freshworks/payloads/note.json')
    * notePayload.body = "Note1"
    And request notePayload
    When method post
    Then status 201

    * def noteId = response.conversation.id
    Given path 'api', '_', 'conversations', noteId
    * header x-csrf-token = csrfToken
    When method delete
    Then status 204


  Scenario: Delete a note from a ticket which is already deleted
    Given path 'api', '_', 'tickets', ticketId, 'notes'
    * header x-csrf-token = csrfToken
    And def notePayload = read('classpath:com/freshworks/payloads/note.json')
    * notePayload.body = "Note1"
    And request notePayload
    When method post
    Then status 201

    * def noteId = response.conversation.id
    Given path 'api', '_', 'conversations', noteId
    * header x-csrf-token = csrfToken
    When method delete
    Then status 204

    Given path 'api', '_', 'conversations', noteId
    * header x-csrf-token = csrfToken
    When method delete
    Then status 404



