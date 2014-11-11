require "spec_helper"

describe "layouts/dtu" do
  it "renders content_for :head" do
    view.content_for :head do
      tag :meta, {:hello => 'world'}, true
    end
    render
    # unfortunately we can't use have_xpath here since we are looking
    # for something outside the body tag
    expect(rendered).to match(/meta hello="world"/)
  end

  it "renders content_for :masthead" do
    view.content_for :masthead do
      content_tag :div, 'This is in the masthead', :class => 'masthead'
    end
    render
    expect(rendered).to have_css('div.masthead', :text => 'This is in the masthead')
  end

  it "renders content_for :logo" do
    view.content_for :logo do
      content_tag :div, 'This is the logo', :class => 'logo'
    end
    render
    expect(rendered).to have_css('div.logo', :text => 'This is the logo')
  end

  it "renders content_for :modal" do
    view.content_for :modal do
      content_tag :div, 'This is a modal', :class => 'modal'
    end
    render
    expect(rendered).to have_css('div.modal', :text => 'This is a modal')
  end

end
