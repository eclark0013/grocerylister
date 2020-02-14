class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def hacker?(current_user)
    self.user != current_user
  end

end
