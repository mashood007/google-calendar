# spec/requests/calendars_spec.rb

require 'rails_helper'

RSpec.describe "Calendars", type: :request do
  let(:user) { create(:user) }
  let(:calendar1) { create(:calendar, user: user) }
  let(:calendar2) { create(:calendar, user: user) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'GET /calendars' do
    context 'when the user is not authenticated' do
      it 'redirects to the login page' do
        get calendars_path
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the user is authenticated' do
      before do
        calendar1
        calendar2
      end

      it 'returns a successful response' do
        get calendars_path
        expect(response).to have_http_status(:ok)
      end

      it 'loads the user’s calendars' do
        get calendars_path
        expect(assigns(:calendars)).to match_array([calendar1, calendar2])
      end
    end
  end
end
