module Authorizer
  extend ActiveSupport::Concern

  def abilities
    @abilites ||= Six.new
  end

  def can?(object, action, subject)
    if subject.respond_to? :each 
      subject.each do |s| 
        return false unless abilities.allowed?(object, action, s)
      end
    end
    abilities.allowed?(object, action, subject)
  end
end
