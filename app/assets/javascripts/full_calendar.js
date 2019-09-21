var initialize_calendar;
initialize_calendar = function(patient_id) {
  $('.full_calendar').each(function(){
    var calendar = $(this);

    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      locale: 'es',
      weekends: false,
      fixedWeekCount: false,
      startParam: "start_time",
      endParam: "end_time",
      events: '/registry/date_events.json?patient_id='+patient_id,

      select: function(start, end) {
        $(".container.spinner").show();
        $.getScript('/registry/date_events/new?patient_id='+patient_id, function() {

          $('.date-range-picker ').val(moment(start).format("DD/MM/YYYY HH:mm") + ' - ' + moment(end).format("DD/MM/YYYY HH:mm"))
          date_range_picker();
          init_select2();
          $('.start_hidden').val(moment(start).format('DD/MM/YYYY HH:mm'));
          $('.end_hidden').val(moment(end).format('DD/MM/YYYY HH:mm'));

        });

        calendar.fullCalendar('unselect');
      },

      eventDrop: function(event, delta, revertFunc) {
        if (event.end === null) {
          event.end = event.start;
        }
        event_data = { 
          registry_date_event: {
            id: event.id,
            start_time: event.start.format(),
            end_time: event.end.format()
          }
        };
        $.ajax({
            url: event.update_url,
            data: event_data,
            type: 'PATCH'
        });
      },
      
      eventClick: function(event, jsEvent, view) {
        $(".container.spinner").show();
        $.getScript(event.edit_url, function() {

          $('.date-range-picker ').val(moment(event.start).format("DD/MM/YYYY HH:mm") + ' - ' + moment(event.end).format("DD/MM/YYYY HH:mm"))
          date_range_picker();
          init_select2();
          $('.start_hidden').val(moment(event.start).format('DD/MM/YYYY HH:mm'));
          $('.end_hidden').val(moment(event.end).format('DD/MM/YYYY HH:mm'));

        });
      }
    });
  })
};
$(document).on('turbolinks:load', function(){
  if(typeof patient_id == 'function') {
    initialize_calendar(patient_id());
  } else {
    initialize_calendar("");
  }
  date_range_picker();
  only_date_range_picker();
  remove_events();

});

$(document).ready(function(){
  if(typeof patient_id == 'function') {
    initialize_calendar(patient_id());
  } else {
    initialize_calendar("");
  }
  date_range_picker();
  only_date_range_picker();
  remove_events();
  
});

remove_events = function() {
  $(".fc-next-button, .fc-prev-button").each(function(){
    $(this).on("click", function(){
      if($(".fc-month-button").hasClass("fc-state-active")) {
        $(".full_calendar").each(function(){
          var calendar = $(this);
          calendar.fullCalendar('removeEvents');
        });
      }
    });
  });
};

var date_range_picker, only_date_range_picker;
date_range_picker = function() {
  $('.date-range-picker').each(function(){
    $(this).daterangepicker({
        timePicker: true,
        timePickerIncrement: 30,
        alwaysShowCalendars: true,
        showDropdowns: true,
        opens: 'right',
        timePicker: true,
        timePickerIncrement: 30,
        timePicker12Hour: true,

        separator: ' hasta ',
        locale: {
          format: 'DD/MM/YYYY HH:mm',
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
      $('.start_hidden').val(start.format('DD/MM/YYYY HH:mm'));
      $('.end_hidden').val(end.format('DD/MM/YYYY HH:mm'));
    });
  })
};
only_date_range_picker = function() {
  $('.only-date.date-range').each(function(){
    $(this).daterangepicker({
        // timePicker: true,
        // timePickerIncrement: 30,
        alwaysShowCalendars: true,
        showDropdowns: true,
        opens: 'right',
        timePicker: true,
        timePickerIncrement: 30,
        timePicker12Hour: false,

        separator: ' hasta ',
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
      $('.start_hidden').val(start.format('DD/MM/YYYY'));
      $('.end_hidden').val(end.format('DD/MM/YYYY'));
    });
  });
};