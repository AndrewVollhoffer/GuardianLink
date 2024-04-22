require "application_system_test_case"

class NgosTest < ApplicationSystemTestCase
  setup do
    @ngo = ngos(:one)
  end

  test "visiting the index" do
    visit ngos_url
    assert_selector "h1", text: "Ngos"
  end

  test "should create ngo" do
    visit ngos_url
    click_on "New ngo"

    click_on "Create Ngo"

    assert_text "Ngo was successfully created"
    click_on "Back"
  end

  test "should update Ngo" do
    visit ngo_url(@ngo)
    click_on "Edit this ngo", match: :first

    click_on "Update Ngo"

    assert_text "Ngo was successfully updated"
    click_on "Back"
  end

  test "should destroy Ngo" do
    visit ngo_url(@ngo)
    click_on "Destroy this ngo", match: :first

    assert_text "Ngo was successfully destroyed"
  end
end
