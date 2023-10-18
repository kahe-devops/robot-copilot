*** Settings ***
Documentation       This is a test suite for testing Browser functionality
...                 Using https://marketsquare.github.io/robotframework-browser/Browser.html

Library             Browser
Resource            ../resources/Chromium.resource

Suite Setup         Setup Suite in Chromium    Chromium    ${HEADLESS}
Suite Teardown      Teardown Suite


*** Variables ***
${HEADLESS}     True


*** Test Cases ***
Open Chromium with Browser
    [Documentation]    Open Chromium with Browser
    [Tags]      set-smoke
    New Page    https://robotframework-browser.org/
    Get Text    title    ==    Browser Library

Gherkin Open Chromium with Browser and navigate to page and check title
    [Documentation]    Open Chromium with Browser and navigate to page and check title
    [Tags]      set-smoke
    Given User Opens the Chromium Browser
    When User Navigates to    https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html
    Then The Page Title Should be    Robot Framework User Guide


*** Keywords ***
User Opens the Chromium Browser
    New Browser    Chromium    headless=${HEADLESS}

User Navigates to
    [Arguments]    ${url}
    New Page    ${url}

Then The Page Title Should be
    [Arguments]    ${title}
    Get Text    title    ==    ${title}
