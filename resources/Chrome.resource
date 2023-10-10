*** Settings ***
Documentation    Resource file for Chromium browser
Library          Browser
Resource         ../resources/common.resource


*** Variables ***
${BROWSER}     Chromium
${HEADLESS}    True        


*** Keywords ***

Setup Suite in Chrome
    [Documentation]    Open Chromium browser
    [Arguments]        ${browser}    ${headless}
    New Browser        ${browser}    headless=${headless}

Gherkin Open Chrome with Browser
    Given I open the Chrome browser
    When I navigate to "https://robotframework-browser.org/"
    Then the page title should be "Browser Library"
