#!/usr/bin/env -S ruby -w

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
