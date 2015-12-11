require "rspec"

feature "play the tic tac toe", js: true do
  context "from the new game page" do
    before do
      visit root_path
      form
    end

    context "start a new game" do
      it { expect(page).to have_text("Player X") }
      it { expect(page).to have_selector("#board") }
    end

    context "player x wins" do
      before do
        x_winning
      end
      it { expect(page).to have_text("Player X won the game") }
    end

    context "tie" do
      before do
        tie
      end
      it { expect(page).to have_text("It's a tie") }
    end

    context "restart a new game" do
      before do
        tie
        click_button("New game")
      end
      it do
        expect(page).to have_selector("#x")
        expect(page).to have_selector("#o")
        expect(page).to have_button("Start game")
      end
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
