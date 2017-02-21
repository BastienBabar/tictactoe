require "test_helper"

class GameTest < ActionDispatch::IntegrationTest
  context "from the new game page" do
    setup do
      visit '/'
      form
    end

    should "start a new game" do
      assert_equal "Player X", find('#player').text
    end

    should "player x wins" do
      x_winning
      assert_equal "Player X won the game!", find('#over-message').text
    end

    should "tie" do
      tie
      assert_equal "It's a tie!", find('#over-message').text
    end

    should "restart a new game" do
      tie
      click_button("New game")

      assert_equal "Start game", find('#submit')['value']
    end
  end
end

def form
  fill_in "x", with: "Player X"
  fill_in "o", with: "Player O"
  click_button("Start game")
end

def x_winning
  find_by_id("0").click
  sleep 1
  find_by_id("1").click
  sleep 1
  find_by_id("4").click
  sleep 1
  find_by_id("2").click
  sleep 1
  find_by_id("8").click
end

def tie
  find_by_id("4").click
  sleep 1
  find_by_id("5").click
  sleep 1
  find_by_id("1").click
  sleep 1
  find_by_id("7").click
  sleep 1
  find_by_id("3").click
  sleep 1
  find_by_id("0").click
  sleep 1
  find_by_id("6").click
  sleep 1
  find_by_id("2").click
  sleep 1
  find_by_id("8").click
end
