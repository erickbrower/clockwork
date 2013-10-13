require 'spec_helper'

describe Person do
  fixtures :people

  subject(:person) { people(:basic) }

  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :blog_posts }
end
