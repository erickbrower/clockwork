require 'spec_helper'

describe BlogPost do
  fixtures :blog_posts

  subject(:post) { blog_posts(:raw_post) }

  it { should respond_to :title }
  it { should respond_to :body }
  it { should respond_to :status }
  it { should respond_to :author }

  context 'when validating' do
    describe 'when title is empty' do
       before { post.title = '' }
       it { should_not be_valid }
    end
  end

end
