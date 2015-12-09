require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "GET new" do
    it "assigns a new Game as @game" do
      get :new, {}
      assigns(:game).should be_a_new(Game)
    end
  end
end
