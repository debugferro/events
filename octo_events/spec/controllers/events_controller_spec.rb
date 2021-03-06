require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "EVENTS POST requests" do
    it "should create a new issue if it is non existant" do
      post :create, params: { action: 'created', issue: { number: '1' }}
      expect(Issue.count).to be == 1
    end

    it "should create an event, and it needs to be to the right Issue" do
      issue = Issue.create(number: 1)
      post :create, params: { action: 'created', issue: { number: '1'}}
      expect(Event.count).to be == 1
      expect(Event.last.issue).to eq(issue)
    end
  end

  describe "EVENTS FETCH calls" do
    it "should display a application/json type of answer" do
      get :show, params: { issue_number: 1 }
      expect(response.content_type).to include("application/json")
    end

    it "should display issue events correctly" do
      issue = Issue.create(number: 1)
      Event.create(action: 'create', issue: issue)
      get :show, params: { issue_number: 1 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["events"][0]["action"]).to eq('create')
    end

    it "should return bad request status when issue is not existant" do
      get :show, params: { issue_number: 200 }
      expect(response).to have_http_status(:bad_request)
    end

    it "should display a error message and status 400 when issue is not existant" do
      get :show, params: { issue_number: 200 }
      expect(JSON.parse(response.body)["status"]).to eq(400)
      expect(JSON.parse(response.body)["error"].length).to be > 0
    end

    it "should return bad request status when issue number is not a numeral" do
      get :show, params: { issue_number: "hello" }
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "Private Methods" do
    before(:each) { @Controller = EventsController.new }

    it "Should find an Issue if existant" do
      issue = Issue.create(number: 1)
      issue_to_find = @Controller.send(:find_issue, 1)
      expect(issue_to_find).to eq(issue)
    end

    it "Should create an Issue" do
      response = @Controller.send(:create_issue, 1)
      expect(Issue.count).to eq(1)
    end

    it "Should return false for a non numeric string" do
      response = @Controller.send(:is_numeric?, "hello")
      expect(response).to eq(false)
    end

    it "Should return true for a numeric string" do
      response = @Controller.send(:is_numeric?, "1200")
      expect(response).to eq(true)
    end
  end
end
