RSpec.shared_examples "start a new game" do
  before do
    expect(page).to have_selector("#x")
    expect(page).to have_selector("#o")
    expect(page).to have_button("Start game")
    form
  end

  scenario do
    expect(page).to have_text("Player X")
    expect(page).to have_selector("#board")
  end
end

def form
  fill_in 'x', :with => "Player X"
  fill_in 'o', :with => "Player O"
  click_button("Start game")
end
