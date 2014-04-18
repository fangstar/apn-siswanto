// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require dataTables/extras/TableTools
//= require dataTables/extras/ZeroClipboard.js
//= require_tree .

function callDataTable() {
  $('#data-table').dataTable( {
        "bSort": false,
        "bPaginate": true,
        "iDisplayLength": 25,
        "sDom": 'T<"clear">lfrt',
        "oTableTools": {
            "aButtons": [
                      {
                        "sExtends" : "print",
                        "sButtonText": "Print",
                        "sToolTip": "Print"
                      }
                    ]
        }
    } );
}


$(document).ready( function () {
    callDataTable() ;
} );

$(document).on('page:change', function() {
  $("#data-table").dataTable().fnDestroy();
  callDataTable(); 
});
