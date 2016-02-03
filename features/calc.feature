Feature: LibreOffice Calc tests


  @cell_recalculation
  Scenario: Cell recalculation
    * Start soffice via command with calc parameter
    Then Calc document named like "Untitled 1" is displayed
    * Insert values to table and create sum under them
    Then Correct sum under values
    * Remove values with shortcut ctrl+z
    Then Correct sum under values

  @random_number_generator
  Scenario: Random number generator
    * Start soffice via command with calc parameter
    Then Calc document named like "Untitled 1" is displayed
    * Select "4" columns and "3" rows on table
    * Open random number dialog
    Then Dialog openned
    * Select vaules from "5" and to "7" in random number dialog and confirm
    Then Correct from "5" and to "7" values in table

  @create_non_english_spreadsheet
  Scenario: Creating a Non-English new spreadsheet
    * Start soffice via command with calc parameter
    Then Calc document named like "Untitled 1" is displayed
    * Add "コンサート" to cell "Cell A1" table
    * Add "2012/12/12" to cell "Cell A2" table
    * Add "Kiitos" to cell "Cell B1" table
    * Add "-564.124" to cell "Cell B2" table
    Then Data "コンサート" added to cell "Cell A1"
    Then Data "2012/12/12" added to cell "Cell A2"
    Then Data "Kiitos" added to cell "Cell B1"
    Then Data "-564.124" added to cell "Cell B2"
    * Select "File -> Save" menu
    Then Dialog window named "Save" is displayed
    * In dialog fill out path "/tmp/test_files", name "tmp.ods" and confirm
    Then Check file "tmp.ods" in "/tmp/test_files" exists
    * Select "File -> Exit LibreOffice" menu
    Then soffice shouldn't be running anymore
    * Start soffice via command with calc parameter
    Then Calc document named like "Untitled 1" is displayed
    * Select "File -> Open..." menu
    Then Dialog window named "Open" is displayed
    * In Open dialog select "tmp.ods" from "/tmp/test_files"
    Then Calc document named like "tmp.ods" is displayed
    Then All data in table are consistent
    * Add "コート" to cell "Cell A1" table
    Then Save icon avaiable
    * Select "File -> Save" menu
    * Select "File -> Exit LibreOffice" menu
    Then soffice shouldn't be running anymore
    * Start soffice via command with calc parameter
    Then Calc document named like "Untitled 1" is displayed
    * Select "File -> Open..." menu
    Then Dialog window named "Open" is displayed
    * In Open dialog select "tmp.ods" from "/tmp/test_files"
    Then Calc document named like "tmp.ods" is displayed
    Then All data in table are consistent


  @export_empty_document_to_pdf
  Scenario: Calc - Export an empty document to pdf
    * Start soffice via command with Calc parameter
    Then soffice should start
    * Select "File -> Export as PDF..." menu
    Then Dialog frame window named "PDF Options" is displayed
    * Click the "Export" button in dialog window
    Then Dialog window named "Export" is displayed
    * In dialog fill out path "/tmp/test_files", name "test" and confirm
    Then Check file "test.pdf" in "/tmp/test_files" exists


  @find_in_all_sheets
  Scenario: Find in all sheets
    * Start soffice via command with Calc parameter
    Then soffice should start
    * Add sheet named "Sheet2"
    * Add sheet named "Sheet3"
    * Add "Test" to cell "Cell A1" in table in sheet named "Sheet1"
    * Add "Test" to cell "Cell A1" in table in sheet named "Sheet2"
    * Add "Test" to cell "Cell A1" in table in sheet named "Sheet3"
    * Select "Edit -> Find & Replace..." menu
    Then Dialog frame window named "Find & Replace" is displayed
    * Type "Test" and check option search in all sheets and confirm
    Then Dialog frame window named "Search Results" is displayed
    Then Data searched are consistent


  @export_odf_to_xls
  Scenario: Exporting Non-English MS Excel format 
    * Start soffice via command with Calc parameter
    Then Calc document named like "Untitled" is displayed
    * Add "コンサート" to cell "Cell A1" table
    * Add "-564.12" to cell "Cell A2" table
    Then Data "コンサート" added to cell "Cell A1"
    Then Data "-564.12" added to cell "Cell A2"
    * Save document and close "tmp" with path "/tmp/test_files" as extension "(.xls)"
    Then soffice shouldn't be running anymore
    * Start soffice via command with Calc parameter
    * Select "File -> Open..." menu
    Then Dialog window named "Open" is displayed
    * In Open dialog select "tmp.xls" from "/tmp/test_files"
    Then Calc document named like "tmp" is displayed
    Then Data "コンサート" added to cell "Cell A1"
    Then Data "-564.12" added to cell "Cell A2"


  @store_cell_formats
  Scenario: Calc: store cell formats
    * Start soffice via command with calc parameter
    Then Calc document named like "Untitled 1" is displayed
    * Add "52.1" to cell "Cell A1" table
    * Add "3654" to cell "Cell A2" table
    * Add "-25143542.24423" to cell "Cell B1" table
    * Add "-564.124" to cell "Cell B2" table
    * Select "2" columns and "2" rows on table
    * Select "Format -> Cells..." menu
    Then Dialog frame window named "Format Cells" is displayed
    * In dialog window set up curency and dollar format and confirm
    Then Data "$52" added to cell "Cell A1"
    Then Data "$3,654" added to cell "Cell A2"
    Then Data "-$25,143,542" added to cell "Cell B1"
    Then Data "-$564" added to cell "Cell B2"


  @math_between_string_and_number
  Scenario: Mathematical operations between numbers and strings
    * Start soffice via command with calc parameter
    Then Calc document named like "Untitled 1" is displayed
    * Add "ahoj" to cell "Cell A1" table
    * Add "123" to cell "Cell A2" table
    * Make operation "+" between cell "Cell A1" and cell "Cell A2" to cell "Cell B1"
    Then Data "#VALUE!" added to cell "Cell B1"

  @protecting_calc_sheet
  Scenario: Protecting calc sheet does not allwo user to make changes
    * Start soffice via command with calc parameter
    Then Calc document named like "Untitled 1" is displayed
    * Make sheet as protected
    * Add "a" to cell "Cell A1" table
    Then Dialog window named like "LibreOffice" is displayed
