# spec/controllers/sessions_controller_spec.rb

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:omniauth_data) do
    {
      'info' => {
        'email' => 'user@example.com',
        'name' => 'John Doe'
      },
      'credentials' => {
        'token' => 'access_token',
        'refresh_token' => 'refresh_token',
        'expires_at' => 3600
      },
      'uid' => 'google_uid'
    }
  end

  before do
    # Set OmniAuth test mode and mock the authentication hash
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(omniauth_data)

    # Stubbing services
    request.env['omniauth.auth'] = OmniAuth::AuthHash.new(omniauth_data)

    allow(Calendars::UpdateEventsService).to receive(:call).and_return(double('service', calendar: double('calendar'), success?: true))
    allow(Calendars::WatchService).to receive(:call)
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe 'GET #create' do
    context 'when user is successfully created or updated' do
      it 'logs in the user and redirects to calendars_path' do
        # Simulate the OmniAuth callback
        get :create, params: { provider: 'google_oauth2' }

        expect(session[:user_id]).to be_present
        expect(response).to redirect_to(calendars_path)
        expect(flash[:notice]).to eq('Logged in successfully with Google!')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out the user and redirects to root_path' do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Logged out!')
    end
  end
end
