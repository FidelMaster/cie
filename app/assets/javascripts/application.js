// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery_ujs
//= require recurring_select
//= require moment 
//= require fullcalendar
//= require_tree .
//= require gentelella
//= require gentelella-custom
//= require cocoon
//= require jquery/clockpicker.min
//= require jquery.minicolors



//= stub webRes/plugin
//= stub webRes/scripts
//= stub webRes/jquery.min
//= stub jquery
//= stub show_hide

/*TURBO LINKS WERE REMOVED require turbolinks*/
var end_date = moment();
var start_date = moment();
var birth_date = moment();
var start_medical_date = moment();
var end_medical_date = moment();
function selectAllRow(checked, source) {
	var $headCheckbox = $(source);
	var currentRow = $headCheckbox.closest('tr');
	var rowIndex = -1;
	if (currentRow.length > 0) {
		rowIndex = currentRow.index();
		var currentTable = currentRow.closest('table');
		if (currentTable.length > 0) {
			// we use rowIndex + 1 since jQuery's index() is 1 based but css selector nth-child is zero based
			console.log(rowIndex);
			var sameRowChecks = currentTable.find('tr:nth-child('+(rowIndex+1)+')');
			if (sameRowChecks.length > 0) {
				if (checked) {
					sameRowChecks.find('input[type="checkbox"]').iCheck('check');
				} else {
					sameRowChecks.find('input[type="checkbox"]').iCheck('uncheck');
				}
			}
		}
	}
}
function selectAllColumn(checked, source) {
	var $headCheckbox = $(source);
	var currentTH = $headCheckbox.closest('th');
	var colIndex = -1;
	if (currentTH.length > 0) {
		colIndex = currentTH.index();
		var currentTable = currentTH.closest('table');
		if (currentTable.length > 0) {
			// we use colIndex + 1 since jQuery's index() is 1 based but css selector nth-child is zero based
			console.log(currentTable, colIndex);
			var sameColumnChecks = currentTable.find('tr td:nth-child('+(colIndex+1)+')');
			console.log(sameColumnChecks);
			if (sameColumnChecks.length > 0) {
				if (checked) {
					sameColumnChecks.find('input[type="checkbox"]').iCheck('check');
				} else {
					sameColumnChecks.find('input[type="checkbox"]').iCheck('uncheck');
				}
			}
		}
	}
}
$(document).ready(function(){
	
	var selectColChecks = $('.select_col');
	if (selectColChecks.length > 0) {
		$(document).on('ifChecked', '.select_col', function() {
			selectAllColumn(true, this);
		});
		$(document).on('ifUnchecked', '.select_col', function() {
			selectAllColumn(false, this);
		});
	}

	var selectRowChecks = $('.select_row');
	if (selectRowChecks.length > 0) {
		$(document).on('ifChecked', '.select_row', function() {
			selectAllRow(true, this);
		});
		$(document).on('ifUnchecked', '.select_row', function() {
			selectAllRow(false, this);
		});
	}
	$('.datepicker').daterangepicker({
		autoUpdateInput: true,
		singleDatePicker: true,
		calender_style: "picker_2",
		startDate: start_date,
		maxDate: moment(),
		showDropdowns: true,
		opens: 'right',
		locale: {
			format: 'DD/MM/YYYY',
			applyLabel: 'Aceptar',
			cancelLabel: 'Cancelar',
			fromLabel: 'Desde',
			toLabel: 'Hasta',
			customRangeLabel: 'Custom',
			daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
			monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
			firstDay: 1
		}
	}, function(start, end, label) {
		console.log(start.toISOString(), end.toISOString(), label);
	});
	$('.empty_datepicker').daterangepicker({
		autoUpdateInput: false,
		singleDatePicker: true,
		calender_style: "picker_2",
		maxDate: moment(),
		showDropdowns: true,
		opens: 'right',
		locale: {
			format: 'DD/MM/YYYY',
			applyLabel: 'Aceptar',
			cancelLabel: 'Cancelar',
			fromLabel: 'Desde',
			toLabel: 'Hasta',
			customRangeLabel: 'Custom',
			daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
			monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
			firstDay: 1
		}
	}, function(chosen_date) {
		$('.empty_datepicker').val(chosen_date.format('DD/MM/YYYY'));
	});


	$('.start_date_empty_datepicker').daterangepicker({
		autoUpdateInput: false,
		singleDatePicker: true,
		calender_style: "picker_2",
		maxDate: moment(),
		showDropdowns: true,
		startDate: start_medical_date,
		opens: 'right',
		locale: {
			format: 'DD/MM/YYYY',
			applyLabel: 'Aceptar',
			cancelLabel: 'Cancelar',
			fromLabel: 'Desde',
			toLabel: 'Hasta',
			customRangeLabel: 'Custom',
			daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
			monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
			firstDay: 1
		}
	}, function(chosen_date) {
		$('.start_date_empty_datepicker').val(chosen_date.format('DD/MM/YYYY'));
	});

	$('.end_date_empty_datepicker').daterangepicker({
		autoUpdateInput: false,
		singleDatePicker: true,
		calender_style: "picker_2",
		maxDate: moment(),
		showDropdowns: true,
		startDate: end_medical_date,
		opens: 'right',
		locale: {
			format: 'DD/MM/YYYY',
			applyLabel: 'Aceptar',
			cancelLabel: 'Cancelar',
			fromLabel: 'Desde',
			toLabel: 'Hasta',
			customRangeLabel: 'Custom',
			daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
			monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
			firstDay: 1
		}
	}, function(chosen_date) {
		$('.end_date_empty_datepicker').val(chosen_date.format('DD/MM/YYYY'));
	});

	$('.datepicker.endpicker').daterangepicker({
		autoUpdateInput: true,
		singleDatePicker: true,
		calender_style: "picker_2",
		startDate: end_date,
		showDropdowns: true,
		opens: 'right',
		locale: {
			format: 'DD/MM/YYYY',
			applyLabel: 'Aceptar',
			cancelLabel: 'Cancelar',
			fromLabel: 'Desde',
			toLabel: 'Hasta',
			customRangeLabel: 'Custom',
			daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
			monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
			firstDay: 1
		}
	}, function(start, end, label) {
		console.log(start.toISOString(), end.toISOString(), label);
	});
	$('.datepicker.birth_date').daterangepicker({
		autoUpdateInput: true,
		singleDatePicker: true,
		calender_style: "picker_2",
		startDate: birth_date,
		maxDate: moment(),
		showDropdowns: true,
		opens: 'right',
		locale: {
			format: 'DD/MM/YYYY',
			applyLabel: 'Aceptar',
			cancelLabel: 'Cancelar',
			fromLabel: 'Desde',
			toLabel: 'Hasta',
			customRangeLabel: 'Custom',
			daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
			monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
			firstDay: 1
		}
	}, function(start, end, label) {
		console.log(start.toISOString(), end.toISOString(), label);
	});
	$('.datepicker.timepicker').daterangepicker({
		autoUpdateInput: true,
		singleDatePicker: true,
		calender_style: "picker_2",
		startDate: start_date,
		showDropdowns: true,
		opens: 'right',
		timePicker: true,
	    timePickerIncrement: 30,
	    timePicker12Hour: true,
		locale: {
			format: 'DD/MM/YYYY HH:mm:ss',
			applyLabel: 'Aceptar',
			cancelLabel: 'Cancelar',
			fromLabel: 'Desde',
			toLabel: 'Hasta',
			customRangeLabel: 'Custom',
			daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
			monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
			firstDay: 1
		}
	}, function(start, end, label) {
		console.log(start.toISOString(), end.toISOString(), label);
	});
	
	// Select the submit buttons of forms with data-confirm attribute
	var submit_buttons = $("form[data-confirm] a#delete_records.submit-form");
	// On click of one of these submit buttons
	submit_buttons.on('click', function (e) {

		// Prevent the form to be submitted
		e.preventDefault();

		var button = $(this); // Get the button
		var form = button.closest('form'); // Get the related form
		var msg = form.data('confirm'); // Get the confirm message

		if(confirm(msg)) form.submit(); // If the user confirm, submit the form
	});

	$.fn.recurring_select.texts = {
		locale_iso_code: "es",
		repeat: "Repetir",
		frequency: "Frecuencia",
		daily: "Diariamente",
		weekly: "Semanalmente",
		monthly: "Mensualmente",
		yearly: "Anualmente",
		every: "Todos",
		days: "dia(s)",
		weeks_on: "semana(s) en",
		months: "mes(es)",
		years: "año(s)",
		first_day_of_week: 1,
		day_of_month: "Día del mes",
		day_of_week: "Día de la semana",
		cancel: "Cancelar",
		summary: "Resumen",
		not_recurring: "- No recurrente -",
    	set_schedule: "Agendar recurrencia",
		ok: "OK",
		days_first_letter: ["D", "L", "M", "M", "J", "V", "S"],
		order: ["1st", "2nd", "3rd", "4th", "5th", "Last"]
	}

	$('.clockpicker-rails').clockpicker({
		donetext: "Listo",
		placement: "bottom",
		default: "now"
	});

	$('a').tooltip();
	$('.permissions').tooltip();
});