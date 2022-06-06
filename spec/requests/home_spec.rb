require 'rails_helper'

RSpec.describe "Home page", type: :request do
  context "ルートのレスポンス確認" do
    before { get root_path }
    it { expect(response).to have_http_status(:success) }
  end
end
