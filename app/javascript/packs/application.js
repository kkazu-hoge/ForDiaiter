// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import '@fortawesome/fontawesome-free/js/all';
import Chart from "chart.js/auto";
global.Chart = Chart;
import "home_pulldown";
import "loading";
import "column";
import "notice";
const images = require.context('../../assets/images', true);
const imagePath = (name) => images(name, true);


// .modalを使用できるようにグローバルに定義
window.jQuery = window.$ = require('jquery')

Rails.start()
Turbolinks.start()
ActiveStorage.start()
