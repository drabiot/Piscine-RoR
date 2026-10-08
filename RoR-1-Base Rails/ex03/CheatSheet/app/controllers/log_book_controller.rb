# Displays the diary and records new entries.
class LogBookController < ApplicationController
  def index
    @entries = LogEntry.all
    render 'pages/log-book'
  end

  def create
    LogEntry.create(params[:entry])
    redirect_to log_book_path
  end
end
