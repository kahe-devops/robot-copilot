*** Settings ***
Documentation       This is a test suite for testing Browser functionality
...                 Using https://marketsquare.github.io/robotframework-browser/Browser.html

Resource            ../resources/common.resource

Suite Setup         Setup Suite in ${BROWSER}    ${BROWSER}    ${HEADLESS}
Suite Teardown      Teardown Suite


*** Test Cases ***
Open web browser with Browser library
    [Documentation]    Open ${BROWSER} with Browser
    [Tags]      set-smoke
    New Page    https://robotframework-browser.org/
    Get Text    title    ==    Browser Library

Gherkin Open web browser with Browser library and navigate to page and check title
    [Documentation]    Open ${BROWSER} with Browser and navigate to page and check title
    [Tags]      set-smoke
    Given User Opens the ${BROWSER} Browser
    When User Navigates to    https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html
    Then The Page Title Should be    Robot Framework User Guide


Go to Robotcode Extension Page and Read Latest Version
    [Documentation]    Go to Robotcode Extension Page and Read Latest Version
    [Tags]    set-smoke
    Given User Opens the ${BROWSER} Browser
    When User Navigates to    https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode
    Then The Latest Extension Version Should be Correct


*** Keywords ***
User Opens the ${BROWSER} Browser
    New Browser    ${BROWSER}    headless=${HEADLESS}

User Navigates to
    [Arguments]    ${url}
    New Page    ${url}

Then The Page Title Should be
    [Arguments]    ${title}
    Get Text    title    ==    ${title}

Get Installed Robotcode Version
    [Documentation]    This keyword retrieves the version of the installed Robotcode extension.
    Is Running In CI
    Log    "is_ci=${is_ci}"
    IF  ${is_ci} != ${TRUE}
            ${result}=    Run And Return Rc And Output    code --list-extensions --show-versions | grep robotcode
            ${version_string}=    Split String From Right    ${result[1]}    @
            ${version}=    Get From List    ${version_string}    1
        ELSE IF  ${is_ci} == ${TRUE}
            ${version}=    Get Text    xpath=/html/body/div[4]/div/div/div[2]/div/div/div[2]/div/div/div/div[2]/div[1]/div/table/tbody/tr/td[2]/div[3]/div[5]/div/table/tbody/tr[1]/td[2]
    END
    RETURN    ${version}

The Latest Extension Version Should be Correct
    [Documentation]    The Latest Extension Version Should be Correct to installed version
    ${actualVersion}=    Get Installed Robotcode Version
    ${expectedVersion}=    Get Text    xpath=/html/body/div[4]/div/div/div[2]/div/div/div[2]/div/div/div/div[2]/div[1]/div/table/tbody/tr/td[2]/div[3]/div[5]/div/table/tbody/tr[1]/td[2]
    Should Be Equal As Strings    ${actualVersion}    ${expectedVersion}

Is Running In CI
    ${ci}=    Get Environment Variable    CI    ${EMPTY}
    ${is_ci}=    Convert To Boolean    ${ci}
    Log    "is_ci=${is_ci}"
    Set Suite Variable    ${is_ci}
    RETURN    ${is_ci}
