require 'spec_helper'

feature 'listing Blog Posts' do
  fixtures :blog_posts

  background do
    @posts = BlogPost.all
  end

  scenario 'successfully' do
    visit blog_posts_path
    @posts.each do |p|
      expect(page).to have_content(p.title)
    end
  end
end
