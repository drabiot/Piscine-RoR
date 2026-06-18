#!/usr/bin/env -S ruby -w

class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
