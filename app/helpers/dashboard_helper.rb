require 'lunar'
module DashboardHelper

  def translate_title(name)
    name ? name : "猿攻"
  end


  def get_done(user)
    user.projects.done.count || 0
  end

  def get_errand(user)
    user.total_fee || 0
  end
end
