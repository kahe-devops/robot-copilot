*** Settings ***
Documentation     This is a test suite for testing login functionality
Library           Browser
Resource          ../resources/Chrome.resource

Suite Setup       Setup Suite in Chrome    Chromium    ${HEADLESS}
Suite Teardown    Teardown Suite


*** Variables ***
${HEADLESS}       True

*** Test Cases ***
Open Chrome with Browser
    [Documentation]    Open Chrome with Browser
    [Tags]      smoke
    New Page    https://robotframework-browser.org/
    Get Text    title    ==    Browser Library
