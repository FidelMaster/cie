# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
    timeInputsButton = $('#btn-show-time-inputs')
    timeInputs = $('#time-inputs')

    

    timeInputsButton.click (event) ->
        
        divItemFormGroup = $("<div class='item form-group'>")
        label = $('<label for="registry_event_start_time" class="control-label col-md-3 col-sm-3 col-xs-12">Hora <span class="required">*</label>')
        fieldset = $('<fieldset class="col-md-6 col-sm-6 col-xs-12">')
        divControlGroup = $('<div class="control-group">')
        divControls = $('<div class="controls">')
        divDisplay = $('<div class="xdisplay_inputx form-group has-feedback">')


        timeInput = $("<input type='text' class='form-control clockpicker-rails event-time'>")
        spanIcon = $('<span class="form-control-feedback fa fa-clock-o right" aria-hidden="true">')
        
        divItemFormGroup.insertAfter timeInputs
        divItemFormGroup.append label
        divItemFormGroup.append fieldset
        fieldset.append divControlGroup
        divControlGroup.append divControls
        divControls.append divDisplay
        divDisplay.append timeInput
        spanIcon.insertAfter timeInput

        $('.clockpicker-rails').clockpicker({
            donetext: 'Listo',
            placement: 'bottom',
            default: 'now'
	    });
    
    $('#new_registry_event #send').click (event) ->
        event.preventDefault()
        registry_event_times = $('#registry_event_times')
        values = []
        times = $('.event-time')
        times.each -> 
            values.push this.value
        registry_event_times.val values
        console.log registry_event_times.val()

        $('#new_registry_event').submit()
        
        

            