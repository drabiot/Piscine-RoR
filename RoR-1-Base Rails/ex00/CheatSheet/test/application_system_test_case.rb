require "test_helper"

# Base class for all system tests, configured to run via Selenium/Chrome.
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
