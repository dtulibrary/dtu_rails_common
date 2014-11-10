class TestsController < ApplicationController
  layout 'dtu'
  def index
    Rails.application.config.application_name = 'Test App'
    render html: '', layout: true
  end
end
