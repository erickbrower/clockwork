module Authorizable
  extend ActiveSupport::Concern

  module ClassMethods
    def authorization_actions
      [:view, :create, :update, :delete]
    end

    def all_authorizations
      authorization_actions.collect { |action| :"#{action}_#{self.name.to_s.underscore}" }
    end
  end
end
