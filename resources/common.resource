*** Settings ***
Documentation    Resource file for the test suite
Library          Collections
Library          OperatingSystem
Library          Process
Library          Browser
Library          String


*** Variables ***
${HOME_TITLE}    Browser Library
${HEADLESS}      True
${is_ci}         ${FALSE}
${BROWSER}       Chromium


*** Keywords ***
Setup Suite in ${BROWSER}
    [Documentation]    Open ${BROWSER} browser
    [Arguments]        ${browser}    ${headless}
    New Browser        ${browser}    headless=${headless}

Teardown Suite
    Close Browser
