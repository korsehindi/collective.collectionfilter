
*** Settings *****************************************************************

Resource  keywords.robot

Library  Remote  ${PLONE_URL}/RobotRemote

Test Setup  Open test browser
Test Teardown  Close all browsers


*** Test Cases ***************************************************************

Scenario: Add filter portlets to collection

    Log in as site owner
    Go to  ${PLONE_URL}/testcollection

    Click element  link=Manage portlets
    Element should be visible  css=#plone-contentmenu-portletmanager > ul
    Click element  partial link=Right

    Add search portlet
    Add filter portlet  Subject  or  checkboxes_dropdowns

    Go to  ${PLONE_URL}/testcollection
    Xpath should match X times  //article[@class='entry']  2

    Click element  css=li.filter-dokumant.checkbox input
    Wait until keyword succeeds  5s  1s  Xpath should match X times  //article[@class='entry']  1

    Capture Page Screenshot
    Click element  css=li.filter-all.checkbox input
    #Click element  partial link:All
    Wait until keyword succeeds  5s  1s  Xpath should match X times  //article[@class='entry']  2

    Input text  css=.collectionSearch input[name='SearchableText']  Docu
    Wait until keyword succeeds  5s  1s  Xpath should match X times  //article[@class='entry']  1
    # check for filtered subject checkbox list
    Wait until keyword succeeds  5s  1s  Xpath should match X times  //div[contains(@class, 'filterContent')]//li[contains(@class, 'filterItem')]  3

    # the following doesn't work ... I think no 'keyup' event is fired
    #Clear element text  css=.collectionSearch input[name='SearchableText']
    #Wait until keyword succeeds  5s  1s  Xpath should match X times  //article[@class='entry']  2
    #Wait until keyword succeeds  5s  1s  Xpath should match X times  //div[contains(@class, 'filterContent')]//li[contains(@class, 'filterItem')]  4
