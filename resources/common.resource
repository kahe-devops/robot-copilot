*** Settings ***
Documentation    Resource file for the test suite
Library          Collections
Library          OperatingSystem
Library          Process
Library          Browser


*** Variables ***
${HOME_TITLE}    Browser Library


*** Keywords ***
Teardown Suite
    Close Browser