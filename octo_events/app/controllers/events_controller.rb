class EventsController < ApplicationController
  def create
    @issue ||= find_issue(params[:issue][:number])
    create_issue(params[:issue][:number]) if @issue.blank?
    Event.create(action: params[:action], issue: @issue)
  end

  def show
    issue_number = params[:issue_number]
    if find_issue(issue_number) && is_numeric?(issue_number)
      render json: {
        status: 200,
        events: @found_issue.events.as_json(except: [:id, :issue_id])
      }
    else
      render json: {
        status: 400,
        error: ['The issue number is valid (must be a number) or non existant.']
      }, status: :bad_request
    end
  end

  private

  def find_issue(issue_number)
    @found_issue = Issue.where(number: issue_number).first
  end

  def is_numeric?(string)
    true if Float(string) rescue false
  end


  def create_issue(issue_number)
    @issue = Issue.create(number: issue_number)
  end
end
