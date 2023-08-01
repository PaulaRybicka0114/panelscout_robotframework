*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}      https://dareit.futbolkolektyw.pl/en/login
${BROWSER}        Chrome
${SIGNINBUTTON}     xpath=//*[text()='Sign in']
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@title='Logo Scouts Panel']
${ERRORINFO}        xpath=//*[text()='Identifier or password invalid.']
${REMINDPASSWORD}       xpath=//child::div/a
${REMINDINPUT}      xpath=//*[@id='__next']/div[1]/div/div[1]/div/div/input
${SENDPASSWORD}     xpath=//button
${MESSAGESENT}      xpath=//*[text()='Message sent successfully.']

*** Test Cases ***
Login to the system
    Open Login Page
    Type In Email
    Type In Password
    Click On The Submit Button
    Assert Dashboard
    [Teardown]    Close Browser

Login to the system with incorrect data
    Open Login Page
    Type In Email
    Type In Invalid Password
    Click On The Submit Button
    Assert Error Info
    [Teardown]    Close Browser

Remind password
    Open Login Page
    Click On the Remind Password Button
    Type In Email for Remind
    Click On The Send Button
    Assert Message Sent
    [Teardown]    Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}        ${BROWSER}
    Title Should Be    Scouts panel - sign in
Type in email
    Input Text    ${EMAILINPUT}     user01@getnada.com
Type in password
    Input Text    ${PASSWORDINPUT}      Test-1234
Click on the submit button
    Click Element    xpath=//*[text()='Sign in']
Assert dashboard
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be    Scouts panel
    Capture Page Screenshot    alert.png
Type in invalid password
    Input Text    ${PASSWORDINPUT}      Test-12345
Assert error info
    Wait Until Element Is Visible   ${ERRORINFO}
Click on the remind password button
    Click Element    xpath=//child::div/a
Type in email for remind
    Input Text    ${REMINDINPUT}    user01@getnada.com
Click on the send button
    Click Element    xpath=//button
Assert message sent
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${MESSAGESENT}

