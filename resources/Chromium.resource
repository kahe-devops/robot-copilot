*** Settings ***
Documentation    Resource file for Chromium browser
Library          Browser
Resource         ../resources/common.resource


*** Variables ***
${BROWSER}     Chromium
${HEADLESS}    True        


*** Keywords ***

Setup Suite in Chromium
    [Documentation]    Open Chromium browser
    [Arguments]        ${browser}    ${headless}
    New Browser        ${browser}    headless=${headless}
