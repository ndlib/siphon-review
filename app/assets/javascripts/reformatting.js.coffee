jQuery ($) ->



  setupTableFilters = () ->

    if $(".datatable").size() == 0
      return

    oTable = $('.datatable').dataTable(
      sPaginationType: "bootstrap"
      iDisplayLength: 1000
      bLengthChange: false
    )

    $('.dataTables_filter').append $('.table_filter').html()

    $('.topic_filter').change ->
      oTable.fnFilter($(this).val(), 1, true, false, false)

    input = $('.dataTables_filter').addClass('well').addClass('well-small').find('input')
    input.attr('placeholder', "Search ...")


  $(document).ready ->
    if $('body.print').size() > 0
      window.print();


  setupTableFilters()


  $('.add_volume_button').click (event)->
    if !$('#possible_volumes').val()
      return false

    event.preventDefault()

    id = $('#possible_volumes').val()
    text = $('#possible_volumes').find(":selected").text()

    template = $('.li_template').html()
    template = template.replace(new RegExp('ID', 'g'), id).replace('TITLE', text)

    $('#volume_list').append(template)

    $('#possible_volumes').find(":selected").remove()


  $('#volume_list').on "click", ".delete_volume", (event)->
    event.preventDefault()

    li = $(this).parents('li')
    id = li.attr('id')
    text = li.find('span input').val()
    li.remove()

    $('#possible_volumes').append("<option id=\"#{id}\">#{text}</option>")
