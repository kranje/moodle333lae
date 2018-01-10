@block @block_clampmail
Feature: Block configuration
  In order to communicate effectively
  As someone who can send email
  I need the ability to configure the block

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Test Course | CF101 | 0 | 1 |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
      | student1 | Student | 1 | student1@example.com |
      | student2 | Student | 2 | student2@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | CF101 | editingteacher |
      | student1 | CF101 | student |
      | student2 | CF101 | student |
    And I log in as "teacher1"
    And I am on "Test Course" course homepage
    And I turn editing mode on
    When I add the "Quickmail" block
    Then I should see "Configuration"

  Scenario: Reset system defaults
    Given I follow "Configuration"
    And I follow "Restore system defaults"
    Then I should see "Changes saved"

  Scenario: Filter roles
    Given I follow "Configuration"
    And I set the following fields to these values:
      | Roles to filter by | student |
    And I press "Save changes"
    Then I should see "Changes saved"
    When I follow "Test Course"
    And I follow "Compose new email"
    Then the "roles" select box should contain "Student"
    And the "roles" select box should not contain "Teacher"
    When I press "Cancel"
    And I follow "Configuration"
    And I follow "Restore system defaults"
    Then I should see "Changes saved"

  Scenario: Prepend course name
    Given I follow "Configuration"
    And I set the following fields to these values:
      | Prepend course name | Short name |
    And I press "Save changes"
    Then I should see "Short name"

  Scenario: Receive a copy
    Given I follow "Configuration"
    And I set the following fields to these values:
      | Receive a copy | Yes |
    And I press "Save changes"
    Then I should see "Yes"
    When I follow "Test Course"
    And I follow "Compose new email"
    Then the field "receipt" matches value "1"
