require File.expand_path("../../watirspec/spec_helper", __FILE__)

describe "Browser#timeouts" do

  context "implicit waits" do
    before do
      browser.timeouts.implicit_wait = 0
      browser.goto WatirSpec.url_for 'dynamic.html'
    end

    after { browser.timeouts.implicit_wait = 0 }

    it "should store the implicit wait timeout" do
      expect(browser.timeouts.implicit_wait).to be == 0
    end

    it "should store changes to the implicit wait timeout" do
      browser.timeouts.implicit_wait = 3
      expect(browser.timeouts.implicit_wait).to be == 3
    end

    it "should implicitly wait for a single element" do
      browser.timeouts.implicit_wait = 3
      browser.input(:id, 'adder').click
      expect(browser.div(:id, 'box0')).to exist
    end

    it "should fail to find an element with implicit waits disabled" do
      browser.timeouts.implicit_wait = 3
      browser.timeouts.implicit_wait = 0
      browser.input(:id, 'adder').click
      expect(browser.div(:id, 'box0')).to_not exist
    end

    it "should fail to find an element with insufficient implicit wait" do
      browser.timeouts.implicit_wait = 0.1
      browser.input(:id, 'adder').click
      expect(browser.div(:id, 'box0')).to_not exist
    end

    it "should implicitly wait until at least one element is found when searching for many" do
      browser.timeouts.implicit_wait = 3
      2.times { browser.input(:id, 'adder').click }
      expect(browser.divs(:class_name, 'redbox').size).to be > 0
    end

    it "should fail to find any elements with insufficient implicit wait" do
      browser.timeouts.implicit_wait = 0.1
      2.times { browser.input(:id, 'adder').click }
      expect(browser.divs(:class_name, 'redbox').size).to be == 0
    end

    it "should return after first attempt to find many after disabling implicit waits" do
      browser.timeouts.implicit_wait = 3
      browser.timeouts.implicit_wait = 0
      browser.input(:id, 'adder').click
      expect(browser.divs(:class_name, 'redbox').size).to be == 0
    end
  end

  describe "execute async script" do
    before {
      browser.timeouts.script_timeout = 0
      browser.goto WatirSpec.url_for("ajaxy_page.html")
    }

    it "should be able to return arrays of primitives from async scripts" do
      result = browser.execute_async_script "arguments[arguments.length - 1]([null, 123, 'abc', true, false]);"
      expect(result).to be == [nil, 123, 'abc', true, false]
    end

    it "should be able to pass multiple arguments to async scripts" do
      result = browser.execute_async_script "arguments[arguments.length - 1](arguments[0] + arguments[1]);", 1, 2
      expect(result).to be == 3
    end

    it "times out if the callback is not invoked" do
      # Script is expected to be async and explicitly callback, so this should timeout.
      expect { browser.execute_async_script "return 1 + 2;" }.to raise_error(Watir::Wait::TimeoutError)
    end
  end
end
