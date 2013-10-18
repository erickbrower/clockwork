module Authorizer
  extend ActiveSupport::Concern

  def abilities
    @abilites ||= Six.new
  end

  def can?(object, action, subject)
    abilities.allowed?(object, action, subject)
  end

end
