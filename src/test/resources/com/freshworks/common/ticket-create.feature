Feature: Ticket Creation
  Reusable feature for creating a ticket

  Background:
    * url baseUrl

  Scenario: Create a ticket
    Given path 'api', '_', 'tickets'
    * cookie _itildesk_session = sessionCookie
    * header x-csrf-token = csrfToken
    And def ticketPayload = read('classpath:com/freshworks/payloads/ticket.json')
    And request ticketPayload
    When method post
    Then status 201