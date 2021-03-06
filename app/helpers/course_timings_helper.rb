# frozen_string_literal: true

module CourseTimingsHelper
  def parse_percentage_from_unlock_condition(condition)
    if condition =~ /^(\d+)[%]\s+(?:in|of|from)\s+(\S+)$/
      percentage = Integer(Regexp.last_match(1))
    end
    percentage
  end

  def parse_group_from_unlock_condition(condition)
    condition.split.last if condition =~ /^(\d+)[%]\s+(?:in|of|from)\s+(\S+)$/
  end

  def complex_unlock_conditions?(group)
    return false if group.group_unlock_conditions.empty?
    return true if group.group_unlock_conditions.length > 1
    return false if group.group_unlock_conditions.first.empty?
    return true unless group.group_unlock_conditions.first =~ /^(\d+)[%]\s+(?:in|of|from)\s+(\S+)$/
    false
  end
end
