Feature: General actions

  @start_soffice_via_command
  Scenario Outline: Start soffice via command
    * Start soffice via command with <component> parameter
    Then soffice should start
    And <component> document named like "Untitled" is displayed

  Examples: Components
    | component |
    | Impress   |
    | Calc      |
    | Writer    |
    | Draw      |

  @quit_soffice_via_shortcut
  Scenario Outline: Ctrl-Q to quit soffice
    * Start soffice via command with <component> parameter
    * Press "<Ctrl>q"
    Then soffice shouldn't be running anymore

  Examples: Components
    | component |
    | Impress   |
    | Calc      |
    | Writer    |
    | Draw      |

  @start_soffice_via_menu
  Scenario Outline: Start soffice via menu
    * Start soffice via menu with <component> parameter
    Then soffice should start
    And <component> document named like "Untitled" is displayed

  Examples: Components
    | component |
    | Impress   |
    | Calc      |
    | Writer    |
    | Draw      |

  @quit_soffice_via_menu
  Scenario Outline: Quit soffice via menu
    * Start soffice via command with <component> parameter
    * Select "File -> Exit LibreOffice" menu
    Then soffice shouldn't be running anymore

  Examples: Components
    | component |
    | Impress   |
    | Calc      |
    | Writer    |
    | Draw      |

  @close_soffice_via_gnome_panel
  Scenario Outline: Close soffice via GnomeShell menu
    * Start soffice via menu with <component> parameter
    * Click "Quit LibreOffice" in GApplication menu
    Then soffice shouldn't be running anymore

  Examples: Components
    | component |
    | Impress   |
    | Calc      |
    | Writer    |
    | Draw      |

  @soffice_about
  Scenario Outline: Show soffice About dialog
    * Start soffice via command with <component> parameter
    Then <component> document named like "Untitled" is displayed
    * Select "Help -> About LibreOffice" menu
    Then About dialog is displayed

  Examples: Components
    | component |
    | Impress   |
    | Calc      |
    | Writer    |
    | Draw      |

  @soffice_license
  Scenario Outline: Show soffice License information
    * Start soffice via command with <component> parameter
    Then <component> document named like "Untitled" is displayed
    * Select "Help -> License Information..." menu
    Then Window named "Licensing and Legal information" is displayed
    * Click the "Show License" button in dialog window
    Then Writer document named like "LICENSE.fodt" is displayed

  Examples: Components
    | component |
    | Impress   |
    | Calc      |
    | Writer    |
    | Draw      |

  @soffice_file_open
  Scenario Outline: Open file via menu
    * Start soffice via command with <component> parameter
    Then <component> document named like "Untitled" is displayed
    * Select "File -> Open..." menu
    Then Dialog window named "Open" is displayed
    * In Open dialog select "<filename>" from "/tmp/test_files"
    Then <component> document named like "<filename>" is displayed

  Examples: Component files
    | component | filename    |
    | Impress   | impress.odp |
    | Calc      | calc.ods    |
    | Writer    | writer.odt  |
    | Draw      | draw.odg    |

  @soffice_export_pdf
  Scenario Outline: Export PDF file via menu
    * Start soffice via command with <component> parameter
    Then <component> document named like "Untitled" is displayed
    * Select "File -> Export as PDF..." menu
    Then Window named "PDF Options" is displayed
    * Click the "Export" button in dialog window
    Then Dialog window named "Export" is displayed
    * In dialog fill out path "/tmp/test_files", name "<filename>" and confirm
    Then Check file "<filename>" in "/tmp/test_files" exists

  Examples: Component files
    | component | filename    |
    | Impress   | impress.pdf |
    | Calc      | calc.pdf    |
    | Writer    | writer.pdf  |
    | Draw      | draw.pdf    |

  @soffice_file_save
  Scenario Outline: Save file via menu
    * Start soffice via command with <component> parameter
    Then <component> document named like "Untitled" is displayed
    * Insert example data into <component> document
    * Select "File -> Save" menu
    Then Dialog window named "Save" is displayed
    * In dialog fill out path "/tmp/test_files", name "<filename>" and confirm
    Then Check file "<filename>" in "/tmp/test_files" exists

  Examples: Component files
    | component | filename       |
    | Impress   | impress_ex.odp |
    | Calc      | calc_ex.ods    |
    | Writer    | writer_ex.odt  |
    | Draw      | draw_ex.odg    |
