require File.expand_path("../../watirspec/spec_helper", __FILE__)

describe "Defaults to When Present" do

  before do
    browser.goto WatirSpec.url_for("wait.html", :needs_server => true)
  end


  it "yields when the element becomes present" do
    called = false

    browser.a(:id, 'show_bar').click
    browser.div(:id, 'bar').when_present(2) { called = true }

    expect(called).to be true
  end

  it "waits until element is present to click" do
    browser.a(:id, 'show_bar').click

    bar = browser.div(:id, 'bar')
    expect { bar.click }.to_not raise_error
    expect(bar.text).to eq "changed"
  end

  it "throws Object Not Visible error when attempting to click on element that exists but is not visible" do
    current_timeout = Watir.default_timeout
    Watir.default_timeout = 1
    expect {
      browser.div(:id, 'bar').click
    }.to raise_error(Watir::Exception::ObjectNotVisibleException,
                     /^element exists but not displayed, using (\{:id=>"bar", :tag_name=>"div"\}|\{:tag_name=>"div", :id=>"bar"\}) after waiting #{Watir.default_timeout} seconds$/
         )
    Watir.default_timeout = current_timeout
  end
end
