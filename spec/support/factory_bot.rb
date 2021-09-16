require 'devise'
require_relative 'controller_macros'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include FactoryBot::Syntax::Methods
  config.extend ControllerMacros, type: :controller
end

RSpec.shared_context :login_user do
  let(:user) { FactoryBot.create(:user) }
  before { sign_in user }
end
