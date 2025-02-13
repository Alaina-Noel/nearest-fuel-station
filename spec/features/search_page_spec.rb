require 'rails_helper'

RSpec.describe 'search page', type: :feature do
  describe 'As a visitor' do
    describe 'When I visit the show page' do
        before :each do
          visit '/'
          select "Turing", from: "location" 
          click_button("Find Nearest Station")
          expect(current_path).to eq("/search")
        end

      it 'I can see the nearest electric fuel station to me with the name, address, fuel type, and access times' do
        within('#nearest_station') do 

          expect(page).to have_content('Address: 400 15th St Denver CO 80202')
          expect(page).to have_content('Name of Station:Tremont Street Garage')
          expect(page).to have_content('Fuel Type: ELEC')
          expect(page).to have_content('Hours of Operation: Garage business hours; pay lot')
        end
      end

      it 'I should also see the distance to the nearest station to the 0.1 miles, travel time from turing to that station (nearest minute)' do 

        within('#nearest_station') do 
          expect(page).to have_content('0.8 miles away')
        end
      end

      it 'I should also see and direction instructions to get to that fuel station ' do 

        expect(page).to have_content("Start out going southeast on 17th St toward Larimer St/CO-33")
        expect(page).to have_content("Turn right onto Tremont Pl.")
        expect(page).to have_content("Turn right onto 15th St.")
        expect(page).to have_content("400 15TH ST is on the left.")
      end
    end
  end
end