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
    input.attr('placeholder', "Search for a book")


  $(document).ready ->
    if $('body.print').size() > 0
      window.print();


  setupTableFilters()
