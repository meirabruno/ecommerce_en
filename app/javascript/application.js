//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery.mask.min.js
//= require products

import "trix"
import "@rails/actiontext"

if($('.currency').length) $('.currency').mask('000.000.000.000.000,00', { reverse: true });
