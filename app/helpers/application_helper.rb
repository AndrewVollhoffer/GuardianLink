module ApplicationHelper

  def user_signed_in?
    if @_current_user != nil
      return true
    end
  end

  def current_user
    return @_current_user
  end

end
