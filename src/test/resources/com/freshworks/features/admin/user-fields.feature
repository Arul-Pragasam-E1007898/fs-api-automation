@test
Feature: Requester form fields CRUD

  Background:
    * url baseUrl
    * def username = 'fs.test12@gmail.com'
    * def password = 'freshservice321'
    * callonce read('classpath:com/freshworks/common/bootstrap-auth.feature')
    * cookie _itildesk_session = sessionCookie
    * header x-csrf-token = csrfToken
    * def sleep = function(seconds){ java.lang.Thread.sleep(seconds*1000) }

    * def get_field_from_form =
    """
    function(field_name){
      var path = "$[?(@.contact_field.label == '" + field_name + "')].contact_field";
      return karate.jsonPath(response, path);
    }
    """

  Scenario: Fetch requester form fields
    Given path 'admin', 'user_fields.json'
    When method get
    Then status 200

    * print get_field_from_form('first_name')

  Scenario: Create requester form fields
    Given path 'admin', 'user_fields.json'
    When method get
    Then status 200

    * def field_group_id = get_field_from_form('Department')[0].user_field_group_id
    * def payload = read('classpath:com/freshworks/payloads/admin/user-fields.json')
    * payload[0].user_field_group_id = field_group_id
    * payload[0].action = 'create'
    * payload[0].id = null
    * payload[0].label = 'TextField1'
    * payload[0].label_in_portal = 'TextField1'

    * def text_field = get_field_from_form('TextField1')
    * print payload
    * if(karate.sizeOf(text_field) == 0) karate.call('classpath:com/freshworks/common/form/user/requester_fields.feature')


  Scenario: Delete requester form fields
    Given path 'admin', 'user_fields.json'
    When method get
    Then status 200

    * def field_group_id = get_field_from_form('Department')[0].user_field_group_id
    * def payload = read('classpath:com/freshworks/payloads/admin/user-fields.json')
    * payload[0].user_field_group_id = field_group_id
    * payload[0].action = 'create'
    * payload[0].id = null
    * payload[0].label = 'TextField2'
    * payload[0].label_in_portal = 'TextField2'

    * def text_field = get_field_from_form('TextField2')
    * print payload
    * if(karate.sizeOf(text_field) == 0) karate.call('classpath:com/freshworks/common/form/user/requester_fields.feature')

    Given path 'admin', 'user_fields.json'
    When method get
    Then status 200

    * payload[0].id = get_field_from_form('TextField2')[0].id
    * payload[0].action = 'delete'
    * karate.call('classpath:com/freshworks/common/form/user/requester_fields.feature')