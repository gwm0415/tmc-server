
# frozen_string_literal: true

# Helper methods for making breadcrumbs.
#
# See https://github.com/weppos/breadcrumbs_on_rails
module BreadcrumbHelpers # Included in ApplicationController
  def add_organization_breadcrumb
    add_breadcrumb "Organization #{@organization.name}", organization_path(@organization)
  end

  def add_course_breadcrumb
    add_organization_breadcrumb
    add_breadcrumb "Course #{@course.name}", organization_course_path(@organization, @course)
  end

  def add_exercise_breadcrumb
    if @exercise
      add_breadcrumb "Exercise #{@exercise.name}", exercise_path(@exercise)
    elsif @submission&.exercise
      add_breadcrumb "Exercise #{@submission.exercise.name}", exercise_path(@submission.exercise)
    elsif @submission&.exercise_name
      add_breadcrumb "(deleted exercise #{@submission.exercise_name}"
    else
      raise 'Neither @exercise nor @submission.exercise_name set'
    end
  end

  def add_submission_breadcrumb
    add_breadcrumb "Submission ##{@submission.id}", submission_path(@submission)
  end
end
