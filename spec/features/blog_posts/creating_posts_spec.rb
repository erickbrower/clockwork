require 'spec_helper'

feature 'creating Blog Posts' do
  fixtures :blog_posts

  background do
    @post = blog_posts :raw_post
  end

  scenario 'successfully' do
    expect do
      visit new_blog_post_path
      fill_in 'blog_post[title]', with: @post.title
      fill_in 'blog_post[body]', with: @post.body
      click_on 'Post'
    end.to change { BlogPost.count }.by(1)
  end

end
