require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      message: "MyString",
      likes_count: 1,
      image_url: "MyString"
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input[name=?]", "post[message]"

      assert_select "input[name=?]", "post[likes_count]"

      assert_select "input[name=?]", "post[image_url]"
    end
  end
end
