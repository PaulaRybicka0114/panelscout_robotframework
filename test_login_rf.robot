*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}      https://scouts-test.futbolkolektyw.pl/en
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
${ADDPLAYERBUTTON}  xpath=//*/div[2]/div/div/a/button
${PLAYERSEMAIL}     xpath=//div[1]/div/div/input
${PLAYERSNAME}      xpath=//div[2]/div/div/input
${PLAYERSSURNAME}       xpath=//div[3]/div/div/input
${PLAYERSPHONE}     xpath=//div[4]/div/div/input
${PLAYERSWEIGHT}        xpath=//div[5]/div/div/input
${PLAYERSHEIGHT}        xpath=//div[6]/div/div/input
${PLAYERSCLUB}      xpath=//div[9]/div/div/input
${PLAYERSLEVEL}     xpath=//div[10]/div/div/input
${PLAYERSMAINPOSITION}      xpath=//div[11]/div/div/input
${PLAYERSSECONDPOSITION}        xpath=//div[12]/div/div/input
${PLAYERSACHIEVEMENTS}      xpath=//div[14]/div/div/input
${SUBMITPLAYERBUTTON}       xpath=//*/div[3]/button[1]
${PLAYERSAGE}       xpath=//div[7]/div/div/input
${REQUIREDAGEINFO}      xpath=//div[7]/div/p
${CLEARPLAYERFORMBUTTON}        xpath=//*/div[3]/button[2]

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

Add a player form without required age field
    Open Login Page
    Type In Email
    Type In Password
    Click On The Submit Button
    Assert Add A Player Form Button
    Click On Add Player Button
    Type In Player's Email
    Type In Player's Name
    Type In Player's Surname
    Type In Player's Phone
    Type In Player's Weight
    Type In Player's Height
    Type In Player's Club
    Type In Player's Level
    Type In Player's Main Position
    Type In Player's Second Position
    Type In Player's Achievements
    Click On Submit Player Button
    Click On Age Field
    Click On Submit Player Button
    Assert Required Age Info
    [Teardown]    Close Browser

Clear Add a player form
    Open Login Page
    Type In Email
    Type In Password
    Click On The Submit Button
    Assert Add A Player Form Button
    Click On Add Player Button
    Type In Player's Email
    Type In Player's Name
    Type In Player's Surname
    Type In Player's Phone
    Type In Player's Weight
    Type In Player's Height
    Type In Player's Club
    Type In Player's Level
    Type In Player's Main Position
    Type In Player's Second Position
    Type In Player's Achievements
    Click On Clear Button
    Assert Form Is Cleared
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
Assert add a player form button
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${ADDPLAYERBUTTON}
Click on add player button
    Click Element    xpath=//*/div[2]/div/div/a/button
Type in player's email
    Input Text    ${PLAYERSEMAIL}   user01@getnada.com
Type in player's name
    Input Text    ${PLAYERSNAME}   Jan
Type in player's surname
    Input Text    ${PLAYERSSURNAME}     Nowak
Type in player's phone
    Input Text    ${PLAYERSPHONE}   123456789
Type in player's weight
    Input Text    ${PLAYERSWEIGHT}  100
Type in player's height
    Input Text    ${PLAYERSHEIGHT}  190
Type in player's club
    Input Text    ${PLAYERSCLUB}    Culture Club
Type in player's level
    Input Text    ${PLAYERSLEVEL}   high
Type in player's main position
    Input Text    ${PLAYERSMAINPOSITION}    shooter
Type in player's second position
    Input Text    ${PLAYERSSECONDPOSITION}  none
Type in player's achievements
    Input Text    ${PLAYERSACHIEVEMENTS}    yes
Click on submit player button
    Click Element   xpath=//*/div[3]/button[1]
Click on age field
    Click Element    xpath=//div[7]/div/div/input
Assert required age info
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible   ${REQUIREDAGEINFO}
Click on clear button
    Click Element    xpath=//*/div[3]/button[2]
Assert form is cleared
    Wait Until Element Does Not Contain    ${PLAYERSNAME}   Jan

