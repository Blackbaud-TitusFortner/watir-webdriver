require 'headless'
Headless.new.start

case ENV['WATIR_CONFIG']
  when 'chrome'
    ENV['WATIR_WEBDRIVER_BROWSER'] = "chrome"
    Watir.always_locate = true
    Watir.prefer_css = false
    puts "Using #{ENV['WATIR_CONFIG']} Configuration"
  when 'firefox'
    ENV['WATIR_WEBDRIVER_BROWSER'] = "firefox"
    Watir.always_locate = true
    Watir.prefer_css = false
    puts "Using #{ENV['WATIR_CONFIG']} Configuration"
  when 'chrome_locate'
    ENV['WATIR_WEBDRIVER_BROWSER'] = "chrome"
    Watir.always_locate = false
    Watir.prefer_css = false
    puts "Using #{ENV['WATIR_CONFIG']} Configuration"
  when 'firefox_locate'
    ENV['WATIR_WEBDRIVER_BROWSER'] = "firefox"
    Watir.always_locate = false
    Watir.prefer_css = false
    puts "Using #{ENV['WATIR_CONFIG']} Configuration"
  when 'chrome_css'
    ENV['WATIR_WEBDRIVER_BROWSER'] = "chrome"
    Watir.always_locate = true
    Watir.prefer_css = true
    puts "Using #{ENV['WATIR_CONFIG']} Configuration"
  when 'firefox_css'
    ENV['WATIR_WEBDRIVER_BROWSER'] = "firefox"
    Watir.always_locate = true
    Watir.prefer_css = true
    puts "Using #{ENV['WATIR_CONFIG']} Configuration"
  else
    puts "Did Not Load from ENV['WATIR_CONFIG']"
end