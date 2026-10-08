// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import $ from "jquery"
window.jQuery = $
window.$ = $

import "bootstrap"
import "datatables.net-bs4"

import "./quick_search"
import "./log_book"
