require "application_system_test_case"

class CsvFilesTest < ApplicationSystemTestCase
  setup do
    @csv_file = csv_files(:one)
  end

  test "visiting the index" do
    visit csv_files_url
    assert_selector "h1", text: "Csv Files"
  end

  test "creating a Csv file" do
    visit csv_files_url
    click_on "New Csv File"

    click_on "Create Csv file"

    assert_text "Csv file was successfully created"
    click_on "Back"
  end

  test "updating a Csv file" do
    visit csv_files_url
    click_on "Edit", match: :first

    click_on "Update Csv file"

    assert_text "Csv file was successfully updated"
    click_on "Back"
  end

  test "destroying a Csv file" do
    visit csv_files_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Csv file was successfully destroyed"
  end
end
