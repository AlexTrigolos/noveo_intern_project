// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require bootstrap-sprockets
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("confirm_logout").onclick = function() { return confirm("Do you really want to get out?"); };
    document.getElementById("confirm_zip").onclick = function() { return confirm("Do you need a zip?"); };
    document.getElementById("confirm_xlsx").onclick = function() { return confirm("Do you need a xlsx?"); };
});
