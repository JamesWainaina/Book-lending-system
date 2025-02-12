# config/importmap.rb

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
#
# Add Rails UJS for handling DELETE and other non-GET methods via links
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.0/dist/rails-ujs.js"

