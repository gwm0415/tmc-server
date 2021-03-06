# frozen_string_literal: true

require 'test_run_grader'
require 'sandbox_results_saver'

# Receives replies from tmc-sandbox.
class ResultsController < ApplicationController
  skip_authorization_check

  def create
    submission = Submission.find(params[:submission_id])

    # The sandbox output may contain broken characters e.g. if the student
    # pointed a C char* towards some patch of interesting memory :)
    filtered_params = Hash[params.map do |k, v|
      [k, view_context.force_utf8_violently(v)]
    end]

    SandboxResultsSaver.save_results(submission, filtered_params)
    Rails.cache.delete("api_v8_core_submission_show_#{submission.id}_user_#{submission.user.id}")
  rescue SandboxResultsSaver::InvalidTokenError
    respond_access_denied('Invalid or expired token')
  else
    render json: 'OK', layout: false
  end
end
