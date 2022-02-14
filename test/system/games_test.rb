require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "h3", count: 10
  end

  test "DICTIONARY gives us sorry message" do
    visit new_url
    fill_in "answer", with: "DICTIONARY"
    click_on "submit"

    assert_text "Sorry but DICTIONARY can't be built out of"
  end

  test "ASDFDFD gives us sorry message" do
    visit new_url
    fill_in "answer", with: "ASDFDFD"
    click_on "submit"

    assert_text "Sorry but ASDFDFD does not seem to be a valid English word..."
  end
end
