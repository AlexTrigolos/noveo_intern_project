// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require bootstrap-sprockets
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function () {
    let logout = document.getElementById("confirm_logout");
    if (logout !== null) {
        logout.onclick = function () {
            return confirm("Do you really want to get out?");
        };
    }
    let zip = document.getElementById("confirm_zip");
    if (zip !== null) {
        zip.onclick = function () {
            return confirm("Do you need a zip?");
        };
    }
    let csv = document.getElementById("confirm_csv");
    if (csv !== null) {
        csv.onclick = function () {
            return confirm("Do you need a csv?");
        };
    }
});
