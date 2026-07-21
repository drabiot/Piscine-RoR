# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jquery" # @4.0.0
pin "datatables.net-bs4" # @2.3.8
pin "datatables.net" # @2.3.8
pin "bootstrap" # @5.3.8
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
