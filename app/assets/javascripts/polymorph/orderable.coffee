class Orderable
  el: '.admin [data-orderable]'

  constructor: ->
    return unless $(@el).length
    $(@el).each @attachSortable

  attachSortable: (i, el) =>
    options = @options(el)
    $(el).sortable options

  options: (el) ->
    options =
      update: ->
        $.post $(@).data('orderable'), $(@).sortable('serialize')

    if $(el).data('orderableItems')
      options.items = $(el).data('orderableItems')

    if $(el).data('orderableAxis')
      options.axis = $(el).data('orderableAxis')

    options

$ ->
  new Orderable
