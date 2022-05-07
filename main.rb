require 'selenium-webdriver'
require 'cucumber'

options = Selenium::WebDriver::Options.chrome
driver = Selenium::WebDriver.for :chrome, options: options

driver.manage.timeouts.implicit_wait = 500

driver.get 'https://google.com'
title_1 = driver.title
puts(title_1)

search_box = driver.find_element(name: 'q')
search_button = driver.find_element(name: 'btnK')

search_box.send_keys  'Selenium'
driver.manage.timeouts.implicit_wait = 500
search_button.click

driver.find_element(name: 'q').attribute('value')

driver.quit