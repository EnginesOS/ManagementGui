$(document).ajaxSuccess ->
  $ ->
    $('.tree li .toggle_node').attr 'title', 'Expand'
    $('.tree li .toggle_node').on 'click', (e) ->
      children = $(this).parent('li').find(' > ul > li')
      if children.is(':visible')
        children.hide 'fast'
        $(this).attr('title', 'Expand').find('.fa-caret-down').addClass('fa-caret-right').removeClass 'fa-caret-down'
      else
        children.show 'fast'
        $(this).attr('title', 'Collapse').find('.fa-caret-right').addClass('fa-caret-down').removeClass 'fa-caret-right'
      e.stopPropagation()
      return
    return
  return
