class WikiPolicy < ApplicationPolicy
  def index
    !(record.private?) || record.user == user
  end
end