require File.expand_path("../../watirspec/spec_helper", __FILE__)

describe "Implicit Waits" do
  before(:each) { browser.timeouts.implicit_wait = 0 }

  it "should wait the expected time to timeout for checking #exist? with both implicit and explicit waits set" do
    explicit_wait = 5
    implicit_wait = 6
    expected_timeout = browser.timeouts.expected_wait(explicit_wait, implicit_wait)

    browser.timeouts.implicit_wait = implicit_wait
    start_time = Time.now
    begin
      Watir::Wait.until(explicit_wait) { browser.input(:id, 'not_here').exist? }
    rescue Watir::Wait::TimeoutError
      expect((Time.now - start_time).round).to be == expected_timeout
    end
  end

  it "should ignore implicit wait when checking for #when_present without a block" do
    explicit_wait = 1
    implicit_wait = 6

    browser.timeouts.implicit_wait = implicit_wait
    start_time = Time.now
    begin
      browser.input(:id, 'not_here').when_present(explicit_wait).exists?
    rescue Watir::Wait::TimeoutError
      expect((Time.now - start_time).round).to be == explicit_wait
    end
  end

  it "should ignore implicit wait when checking for #when_present with a block" do
    explicit_wait = 1
    implicit_wait = 6

    browser.timeouts.implicit_wait = implicit_wait
    start_time = Time.now
    begin
      browser.input(:id, 'not_here').when_present(explicit_wait) { |el| el.exists? }
    rescue Watir::Wait::TimeoutError
      expect((Time.now - start_time).round).to be == explicit_wait
    end
  end

  it "should ignore implicit wait when checking for #wait_until_present" do
    explicit_wait = 1
    implicit_wait = 6

    browser.timeouts.implicit_wait = implicit_wait
    start_time = Time.now
    begin
      browser.input(:id, 'not_here').wait_until_present(explicit_wait).exists?
    rescue Watir::Wait::TimeoutError
      expect((Time.now - start_time).round).to be == explicit_wait
    end
  end

  it "should ignore implicit wait when checking for #not_exists?" do
    explicit_wait = 1
    implicit_wait = 6

    browser.timeouts.implicit_wait = implicit_wait
    start_time = Time.now
    begin
      browser.input(:id, 'not_here').not_exists?
    rescue Watir::Wait::TimeoutError
      expect((Time.now - start_time).round).to be == explicit_wait
    end
  end
end
