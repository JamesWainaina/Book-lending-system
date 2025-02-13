import Rails from "@rails/ujs";
Rails.start();

console.log('Rails UJS is loaded'); // Confirm Rails UJS is loaded

// Turbo and Stimulus
import { Turbo } from "@hotwired/turbo-rails";
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers"; // Corrected spelling

const application = Application.start();
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));
