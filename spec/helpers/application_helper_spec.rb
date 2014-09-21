require 'rails_helper'

describe 'ApplicationHelper' do
  let (:user) { User.create!(email: "taylorzr@gmail.com", username: "taylorzr", password: "pass") }
  describe '#current_user' do
    it "should return nil if no user is logged in" do
      expect(helper.current_user).to be_nil
    end

    it "should return the user if a user is logged in" do
      session[:user_id] = user.id
      expect(helper.current_user).to eq(user)
    end
  end

  describe '#logged_in?' do
    it "should return false if a user is not logged in" do
      expect(helper.logged_in?).to be_falsey
    end

    it "should return true if a user is logged in" do
      session[:user_id] = user.id
      expect(helper.logged_in?).to be_truthy
    end
  end
end