Feature: Ticket API Tests
  Testing ticket CRUD endpoints

  Background:
    * url baseUrl
    * def username = 'fs.test12@gmail.com'
    * def password = 'freshservice321'
    * callonce read('classpath:com/freshworks/common/bootstrap-auth.feature')

  Scenario: Bulk delete tickets
    * call read('classpath:com/freshworks/common/ticket-create.feature')
    * def ticket1Id = response.ticket.id

    * call read('classpath:com/freshworks/common/ticket-create.feature')
    * def ticket2Id = response.ticket.id

    * call read('classpath:com/freshworks/common/ticket-create.feature')
    * def ticket3Id = response.ticket.id

    Given path 'api', '_', 'tickets', 'delete_multiple'
    * header x-csrf-token = csrfToken
    And param ids = ticket1Id + ',' + ticket2Id + ',' + ticket3Id
    When method delete
    Then status 204



