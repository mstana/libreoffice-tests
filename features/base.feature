Feature: LibreOffice Base tests


  @create_db
  Scenario: Creating a database
    * Start soffice via command with base parameter
    Then base document named like "Database Wizard" is displayed
    * Create database
    * In dialog fill out path "/tmp", name "myDB1" and confirm
    Then Window named "myDB1.odb - LibreOffice Base" is displayed

  @create_table_in_db
  Scenario: Creating a table in a database
    * Start soffice via command with base parameter
    Then base document named like "Database Wizard" is displayed
    * Create database
    * In dialog fill out path "/tmp", name "myDB1" and confirm
    Then Window named "myDB1.odb - LibreOffice Base" is displayed
	  * Create table with name "Table2" in database with name "myDB1" in design mode
    Then Table with name "Table2" created

  @add_records_to_table
  Scenario: Adding records to a table
    * Start soffice via command with base parameter
    Then base document named like "Database Wizard" is displayed
    * Create database
    * In dialog fill out path "/tmp", name "myDB1" and confirm
    Then Window named "myDB1.odb - LibreOffice Base" is displayed
	  * Create table with name "mytable" in database with name "myDB1" in design mode
    Then Table with name "mytable" created
    * Open table "mytable" from main view
    * Enter records to table
    Then Assert "english" records in table with name "mytable" in db "myDB1"

  @add_non_english_records_to_table
  Scenario: Adding records to a table
    * Start soffice via command with base parameter
    Then base document named like "Database Wizard" is displayed
    * Create database
    * In dialog fill out path "/tmp", name "myDB1" and confirm
    Then Window named "myDB1.odb - LibreOffice Base" is displayed
    * Create table with name "mytable" in database with name "myDB1" in design mode
    Then Table with name "mytable" created
    * Open table "mytable" from main view
    * Enter non-english records to table
    Then Assert "non-english" records in table with name "mytable" in db "myDB1"
 