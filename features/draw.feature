Feature: LibreOffice Draw tests

  @draw_draw_a_line
  Scenario: Draw a line
    * Start soffice via command with Draw parameter
    Then Draw document named like "Untitled" is displayed
    * Make sure the Drawing toolbar is visible
    * Select Line tool from Drawing toolbar
    * Draw a line
    Then Document contains an item called "Line "

  @draw_modify_name
  Scenario: Modify name of item
    * Start soffice via command with Draw parameter
    Then Draw document named like "Untitled" is displayed
    * Make sure the Drawing toolbar is visible
    * Select Line tool from Drawing toolbar
    * Draw a line
    Then Document contains an item called "Line "
    * Select "Modify -> Name..." menu
    Then Window named "Name" is displayed
    * In Rename dialog set new name to "New Name"
    Then Document contains an item called "New Name"

  @draw_import_svg
  Scenario: Import SVG file
    * Start soffice via command with Draw parameter
    Then Draw document named like "Untitled" is displayed
    * Select "Insert -> Image..." menu
    Then Dialog window named "Insert Image" is displayed
    * In Open dialog select "svg_file.svg" from "/tmp/test_files"
    Then Document contains an image called "GraphicObjectShape "
