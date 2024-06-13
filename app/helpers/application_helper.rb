module ApplicationHelper

  def profile_completed?(user)
    if !user.ngo?
      if
        # user.profile_photo.attached? &&
        user.attribute_present?(:first_name) &&
        user.attribute_present?(:last_name) &&
        user.attribute_present?(:hours) &&
        user.attribute_present?(:bio) &&
        user.attribute_present?(:linkedin)
        return true
      end
    elsif user.ngo?
      if
        # user.profile_photo.attached? &&
        user.attribute_present?(:first_name) &&
        user.attribute_present?(:bio)
        return true
      end
    end
  end
end
