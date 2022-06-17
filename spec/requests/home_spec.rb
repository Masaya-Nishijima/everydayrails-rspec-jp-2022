require 'rails_helper'

RSpec.describe "Home page", type: :request do
  context "ルートのレスポンス確認" do
    before { get root_path }
    it { expect(response).to have_http_status(:success) }
  end

  context "ログインを要求するリダイレクト" do
    before {get projects_path	}
    it { expect(response).to redirect_to(user_session_path) }
    # http://localhost:3000/projects
    # http://localhost:3000/users/sign_in
  end
end
