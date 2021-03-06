class EventsController < ApplicationController
  def create
    @issue ||= find_issue(params[:issue][:number])
    create_issue(params[:issue][:number]) if @issue.blank?
    Event.create(action: params[:action], issue: @issue)
  end

  def show
    issue = find_issue(params[:issue_number])
    if issue
      render json: {
        status: 200,
        events: issue.events.as_json(except: [:id, :issue_id])
      }
    else
      render json: {
        status: 401,
        error: ['No issue with such number']
      }
    end
  end

  private

  def is_numeric?(string)
    true if Float(string) rescue false
  end

  def find_issue(issue_number)
    Issue.where(number: issue_number).first
  end

  def create_issue(issue_number)
    @issue = Issue.create(number: issue_number)
  end
end
