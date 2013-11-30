@page_editor = (page, settings) ->
  drawing_unit =
    convert_element: (element, typ, cell) ->
      element.css('left', 0 + 'px')
      element.css('top', 0 + 'px')
      dummy = typ + "_dummy"
      classname = typ + '-element'
      element.removeClass(dummy).removeClass('sidebar_dummy')
      element.addClass(classname).addClass('page-element')
      element.children('.editline').show()
      unless typ == 'gallery_slider'
        minimal_gallery_slider = site.minimal_gallery_slider.clone()
        side = cell.attr('class').split(' ')[0].split('cell-element-')[1]
        minimal_gallery_slider.attr('id', '').addClass('minimal_gallery_slider').addClass('gradiant_'+side)
        minimal_gallery_slider.appendTo(cell)
        minimal_gallery_slider.children('.minimal_gallery_slider_field_'+side).show()
      element.appendTo(cell)
    draw: (obj) ->
      element_typ = obj.type
      element = drawing_unit['draw_'+element_typ](obj)
      element.css('top', 0).css('left', 0)
    redraw: () ->
      $('.scaffold-row-element').remove()
      $('.row-element').remove()
      $.each(site.rows, (index, obj) ->
        drawing_unit.draw_row obj
        obj
      )
      $.each(site.cells, (index,obj) ->
        drawing_unit.draw_cell obj
        obj
      )
      $.each(site.textboxes, (index,obj) ->
        drawing_unit.draw_textbox obj
        obj
      )
      $.each(site.images, (index,obj) ->
        drawing_unit.draw_image obj
        obj
      )
      $.each(site.gallery_sliders, (index,obj) ->
        drawing_unit.draw_gallery_slider obj
        obj
      )
      $.each(site.vertical_grids, (index,obj) ->
        drawing_unit.draw_vertical_grid obj
        obj
      )
      $.each(site.horizontal_grids, (index,obj) ->
        drawing_unit.draw_horizontal_grid obj
        obj
      )
    draw_row: (obj, append=true) ->
      page_row = site.dummy_row.clone()
      page_row.attr('data-id', obj.id)
      page_row.css('height', obj.height + 'px')
      page_row.removeClass('dummy_row').addClass('row-element')
      obj.element = page_row
      scaff_row = site.dummy_row.clone()
      scaff_row.attr('data-id', obj.id)
      scaff_row.css('height', obj.height + 'px')
      scaff_row.removeClass('dummy_row').addClass('scaffold-row-element')
      obj.scaffold_element = scaff_row
      unchain_badge = $('<div class="badge badge badge-info scaffold_btn unchain_badge" data-status="'+obj.split+'" id="' + obj.id + '"><i class="icon icon-unlink"></i></div>')
      if append
        page_row.appendTo site.element
        scaff_row.appendTo site.scaffold
        unchain_badge.appendTo(scaff_row)
      page_row
    draw_cell: (obj, append=true) ->
      draw = (obj, append) ->
        page_cell = site.dummy_cell.clone()
        page_cell.attr('data-id', obj.id)
        page_cell.removeClass('dummy_cell')
        page_cell.addClass('cell-element')
        if obj.backgroundcolor == 'true'
          page_cell.css('background-color', site.primaryColor).addClass('colored')
        site.rows[obj.row].cells.push(obj)
        scaff_cell = site.scaffold_dummy_cell.clone()
        scaff_cell.removeClass('scaffold_dummy_cell')
        scaff_cell.addClass('scaffold-element')
        if obj.backgroundcolor == 'true'
          scaff_cell.find('#change_color').html('<i class="icon icon-unchecked"></i>')
        scaff_cell.attr('id', obj.id)
        switch obj.side
          when 0
            $('.unchain_badge[id="' + obj.row + '"]').appendTo(scaff_cell.find('.editbar'))
            scaff_cell.addClass('left')
            scaff_cell.find('.destroy_btn_area').addClass('left')
          when 1
            scaff_cell.addClass('right')
            scaff_cell.find('.destroy_btn_area').addClass('right')
        scaff_cell.find('.destroy_btn_area').attr('id', obj.id)
        obj.scaffold_element = scaff_cell
        obj.element = page_cell
        if append
          page_cell.appendTo $('.row-element[data-id="'+obj.row+'"]')
          page_cell.show()
          scaff_cell.appendTo $('.scaffold-row-element[data-id="'+obj.row+'"]')
          invoker.resize_page()
          invoker.make_cells_droppable()
          invoker.make_scaffold_resizable()
        page_cell
      if !site.rows[obj.row].split
        if obj.side == 0
          draw(obj,append)
          cell = obj.element
          scaff_cell = obj.scaffold_element
          cell.css('width', 100 + '%')
          scaff_cell.css('width', 100 + '%')
          # unchain = $('.unchain_badge[id="' + obj.id + '"]')
          # unchain.css('left', 0 + "%").css('top', 0 + '%').css('margin-left', 0)
      else
        draw(obj, append)
      obj.element
    draw_textbox: (obj) ->
      element = site.textbox_dummy.clone()
      element.attr('id', obj.id)
      element.removeClass('textbox_dummy').removeClass('sidebar_dummy').addClass('textbox-element').addClass('page-element')
      element.appendTo(obj.cell.element)
      element.show()
      if obj.text
        element.find('.show').html(''+obj.text+'')
      else
        element.find('.show').html('<div class="alert alert-info">Noch kein Text vorhanden !</div>')
      switch obj.cell.side
        when 0
          element.find('.destroy').addClass('left').attr('id', obj.cell.id).data('type', obj.type)
          element.find('.edit').addClass('left')
          element.find('.resize_cell').addClass('left')
        when 1
          element.find('.edit').addClass('left')
          element.find('.resize_cell').addClass('left')
          element.find('.destroy').addClass('right').attr('id', obj.cell.id).data('type', obj.type)

      obj.element = element
    draw_image: (obj) ->
      element = site.image_dummy.clone()
      element.attr('id', obj.id)
      element.removeClass('image_dummy').removeClass('sidebar_dummy').addClass('image-element').addClass('page-element')
      element.appendTo(obj.cell.element)
      element.show()
      if obj.image
        element.find('img').attr('src', obj.image.url)
      switch obj.cell.side
        when 0
          element.find('.destroy').addClass('left').attr('id', obj.cell.id).data('type', obj.type)
          element.find('.edit').addClass('left')
          element.find('.resize_cell').addClass('left')
        when 1
          element.find('.edit').addClass('left')
          element.find('.resize_cell').addClass('left')
          element.find('.destroy').addClass('right').attr('id', obj.cell.id).data('type', obj.type)
      obj.element = element
    draw_gallery_slider: (obj) ->
      element = site.gallery_slider_dummy.clone()
      element.attr('id', obj.id)
      element.removeClass('gallery_slider_dummy').removeClass('sidebar_dummy').addClass('gallery_slider-element').addClass('page-element')
      element.appendTo(obj.cell.element)
      element.show()
      switch obj.cell.side
        when 0
          element.find('.destroy').addClass('left').attr('id', obj.cell.id).data('type', obj.type)
          element.find('.edit').addClass('left')
          element.find('.resize_cell').addClass('left')
        when 1
          element.find('.edit').addClass('left')
          element.find('.resize_cell').addClass('left')
          element.find('.destroy').addClass('right').attr('id', obj.cell.id).data('type', obj.type)
      slider = $('<div id="slides"></div>')
      element.find('.show').html(slider)
      $.each(obj.images, (index, image) ->
        tag = $('<img src="' + image + '"></img>')
        tag.appendTo slider
      )
      $('#slides').slidesjs
        width: 100
        pagination:
          active: false
        play:
          active: false
          effect: "slide"
          interval: 4000
          auto: true
          swap: true
          pauseOnHover: true
          restartDelay: 2500
      $('#slides').css('height', 100 + '%')
      $('.slidesjs-container').css('height', 100 + '%')
      $('.slidesjs-control').css('height', 100 + '%')
      $('.slidesjs-previous').html($('<i class="icon-long-arrow-left"></i>'))
      $('.slidesjs-next').html($('<i class="icon-long-arrow-right"></i>'))
      obj.element = element
    draw_vertical_grid: (obj) ->
      element = site.vertical_grid_dummy.clone()
      element.attr('id', obj.id)
      element.removeClass('vertical_grid_dummy').removeClass('sidebar_dummy').addClass('vertical_grid-element').addClass('page-element')
      element.appendTo(obj.cell.element)
      element.show()
    draw_horizontal_grid: (obj) ->
      element = site.horizontal_grid_dummy.clone()
      element.attr('id', obj.id)
      element.removeClass('horizontal_grid_dummy').removeClass('sidebar_dummy').addClass('horizontal_grid-element').addClass('page-element')
      element.appendTo(obj.cell.element)
      element.show()

  page_element =
    row: (data) ->
      @id = data.internal_id
      @server_id = data.id
      @split = data.split
      @type = 'row'
      @arr = 'rows'
      @cells = []
      @element = data.element
      @scaffold_element = data.scaff_element
      @height = data.height
      this
    cell: (data) ->
      @id = data.internal_id
      @server_id = data.id
      # @parent = data.parent
      @type = 'cell'
      @backgroundcolor = data.backgroundcolor
      @cells = []
      @arr = 'cells'
      @side = data.side
      @row = find_by_server_id('row',data.row_id).id
      @element = data.element
      @scaffold_element = data.scaff_element
      this
    textbox: (data) ->
      @type = 'textbox'
      @arr = 'textboxes'
      @id = data.internal_id
      @server_id = data.id
      @element = data.element
      @cell = data.cell_id
      @side = data.side
      @text = data.text
      this
    image: (data) ->
      @type  = 'image'
      @arr = 'images'
      @id = data.internal_id
      @server_id = data.id
      @element = data.element
      @cell = data.cell_id
      @side = data.side
      @image = data.image
      this
    gallery_slider: (data) ->
      @type  = 'gallery_slider'
      @gallery_id = data.gallery_id
      @images = []
      @arr = 'gallery_sliders'
      @id = data.internal_id
      @server_id = data.id
      @element = data.element
      @cell = data.cell_id
      @side = data.side
      @height = null
      this
    vertical_grid: (data) ->
      @type  = 'vertical_grid'
      @arr = 'vertical_grids'
      @id = data.internal_id
      @element = data.element
      @server_id = data.id
      @cell = data.cell_id
      @side = data.side
      @grid = data.grid
      this
    horizontal_grid: (data) ->
      @type  = 'horizontal_grid'
      @arr = 'horizontal_grids'
      @id = data.internal_id
      @server_id = data.id
      @cell = data.cell_id
      @element = data.element
      @side = data.side
      @grid = data.grid
      this
  database =
    create: (obj) ->
      path = settings.urls.create_path
      $.ajax path,
        type: "POST"
        data:
          page_element:
            type: obj.type
            internal_id: obj.id
            side: obj.side
            cell_id: parseInt(obj.cell.server_id)
          page_id: site.page_id
        async: false
        success: (data) ->
          obj = find_by_id(data.type, data.ele_info.internal_id)
          obj.server_id = data.ele_info.id
    destroy: (obj) ->
      path = settings.urls.destroy_path.replace('xxx', obj.server_id)
      $.ajax path,
        type: "DELETE"
        data:
          page_element:
            type: obj.type
          page_id: site.page_id
        async: false
        success: (data) ->
          $('.'+data.type+'-element[id="'+data.id+'"]').remove()
          $('.minimal_gallery_slider[id="'+data.id+'"]').remove()
          arr = obj.arr
          $.each(site[arr], (index, obj) ->
            if data.id == obj.id
              site[arr].splice(index, 1)
              return false
          )
          drawing_unit.redraw()
    update: (ar, obj) ->
      up_obj = {}
      for elkey,elval of obj
        $.each(ar, (index, thing) ->
          if thing.name == 'page_element[' + elkey + ']'
            up_obj[elkey] = thing.value
        )
      up_obj['id'] = obj.server_id
      up_obj['type'] = obj.type
      data =
        page_id: site.page_id
        page_element: up_obj
      path = settings.urls.update_path.replace('xxx', obj.server_id)
      $.ajax path,
        type: "PUT"
        async: false
        data: data
        success: (data) ->
          $.each(data.ele_info, (k,v) ->
            for key,val of obj
              unless key == 'id'
                if key == k
                  if key == 'gallery_id'
                    obj['images'] = data.ele_info.images.split(', ')
                  obj[key] = v
          )
          drawing_unit.redraw()

  find_by_server_id = (type, id) ->
    ret_obj = null
    switch type
      when 'row'
        arr = 'rows'
      when 'cell'
        arr = 'cells'
      when 'textbox'
        arr = 'textboxes'
      when 'image'
        arr = 'images'
      when 'gallery_slider'
        arr = 'gallery_sliders'
      when 'vertical_grid'
        arr = 'vertical_grids'
      when 'horizontal_grid'
        arr = 'horizontal_grids'
    $.each(site[arr], (index, obj) ->
      if obj.server_id == id
        ret_obj = obj
        return false
    )
    return ret_obj

  find_by_id = (type, id) ->
    ret_obj = null
    console.log type
    switch type
      when 'row'
        arr = 'rows'
      when 'cell'
        arr = 'cells'
      when 'textbox'
        arr = 'textboxes'
      when 'image'
        arr = 'images'
      when 'gallery_slider'
        arr = 'gallery_sliders'
      when 'vertical_grid'
        arr = 'vertical_grids'
      when 'horizontal_grid'
        arr = 'horizontal_grids'
    $.each(site[arr], (index, obj) ->
      if parseInt(obj.id) == parseInt(id)
        ret_obj = obj
    )
    return ret_obj

  new_id = (type) ->
    ar = []
    switch type
      when 'textbox'
        $.map(site.textboxes,(obj, index)-> ar.push(obj.id))
      when 'image'
        $.map(site.images,(obj, index)-> ar.push(obj.id))
      when 'gallery_slider'
        $.map(site.gallery_sliders,(obj, index)-> ar.push(obj.id))
    if ar.length < 1
      id = 0
    else
      id = Math.max.apply(Math, ar) + 1
    id

  invoker =
      modals:
        invoke_whysihtml: () ->
          $('.whysihtml').wysihtml5();
        invoke_uploader: (obj) ->
          $('.uploader').fineUploader(
            multiple: false
            autoUpload: true
            request:
              inputName: 'image'
              params:
                page_id: site.page_id
                page_element:
                  type: obj.type
                  id: obj.server_id
              endpoint: settings.urls.upload_path.replace('xxx',obj.server_id)
          ).on('error', (event, id, name, reason) ->
            console.log reason
          ).on('complete', (event, id, filename, data) ->
            $(this).parents('.modal').find('#target_image').attr('src', data.element.image.normal.url)
          )
        edit: (id, type, body='') ->
          obj = find_by_id(type, id)
          id = obj.server_id
          data =
            page_id: site.page_id
            page_element:
              type: obj.type
              id: obj.server_id
          $.ajax(settings.urls.get_form_path.replace('xxx', obj.server_id),
            type: 'GET'
            data: data
            success: (data) ->
              modal = $(data.form)
              modal.on('show', () ->
                $('.right_sidebar').hide()
                $('.left_sidebar').hide()
                $('.navbar').hide()
                $('.pos_marker').hide()
                $('.marker_screen').hide()
                site.scaffold.hide()
              )

              modal.on('shown', () ->
                invoker.modals.invoke_whysihtml()
                invoker.modals.invoke_uploader(obj)
              )

              modal.on('hide', () ->
                $('.right_sidebar').show()
                $('.left_sidebar').show()
                $('.navbar').show()
                $('.pos_marker').show()
                $('.marker_screen').show()
              )
              modal.modal()
          )
        destroy: (id, type, body='') ->
          switch type
            when 'textbox'
              subj = 'wird die Textbox'
            when 'image'
              subj = 'wird das Bild'
            when 'gallery_slider'
              subj = 'wird die Gallery'
            when 'vertical_grid'
              subj = 'werden das Gerüstelement sowie die sich darin befindenden Elemente'
            when 'horizontal_grid'
              subj = 'werden das Gerüstelement sowie die sich darin befindenden Elemente'
          obj = find_by_id(type, id)
          $('#modal_blueprint').html($("<p>Wenn sie bestätigen "+subj+" unwiederruflich gelöscht!<br>" + body + "<p>Wirklich löschen?</p></p>"))
          $('#modal_blueprint').css('background-color', 'white')
          $('#modal_blueprint').dialog
            dialogClass: 'no-close success-dialog'
            closeOnEscape: true
            draggable: false
            width:700
            resizable: false
            title: 'Sind sie sicher?'
            modal: true
            position:
              at: "top"
              of: $(document)
            buttons:
              "OK":
                text: "OK"
                'class': 'btn btn-danger'
                click: () ->
                  obj.cell.scaffold_element.find('.destroy_btn_area').remove()
                  database.destroy(obj)
                  $(this).dialog("close");
                create: () ->
                  $(this).html($('<i class="icon-trash"></i>'))
              "Abbrechen":
                text: "Abbrechen"
                'class': 'btn'
                click: () ->
                  $( this ).dialog( "close" );
      resize_page: (ops = 0) ->
        site.page_height = 0
        $.each(site.rows, (index, obj) ->
          site.page_height += obj.height
        )
        site.element.css('height', site.page_height + ops + 'px')
        site.row.css('height', (site.page_height + ops + 80) + 'px')

      highlight_cells: () ->
        $('.cell-element').on('mouseenter', (event) ->
          $(this).addClass('shiny')
        )

        $('.cell-element').on('mouseleave', (event) ->
          $(this).removeClass('shiny')
        )

        $('.cell-element').on('mouseenter', (event) ->
          $(this).addClass('shiny')
        )

        $('.cell-element').on('mouseleave', (event) ->
          $(this).removeClass('shiny')
        )
      invoke_object: (ui, cell) ->
        type = ui.draggable.attr('class').split(' ')[0].split('_dummy')[0]
        data =
          type: type
          internal_id: new_id(type)
          cell_id: find_by_id('cell', cell.attr('data-id'))
        obj = new page_element[data.type](data)
        site[obj.arr].push(obj)
        database.create(obj)
        drawing_unit.draw(obj)

      make_cells_droppable: () ->
        $('.cell-element').droppable
          over: (event, ui) ->
            $(this).addClass('shiny')
          out: (event, ui) ->
            $(this).removeClass('shiny')
          drop: (event, ui) ->
            $(this).removeClass('shiny')
            id = parseInt($(this).attr('data-id'))
            dropped_element = ui.draggable
            invoker.invoke_object(ui, $(this))
            invoker.relocate_menu_items(ui)

            # if (id + 1) == site.cells.length
              # invoker.resize_page()
              # cell = new
              # TODO: create new cell, redraw cells and reconfigure em
      relocate_menu_items: (ui) ->
        ui.draggable.css('left', 0)
        ui.draggable.css('top', 0)

      make_scaffold_resizable: () ->
        $( ".scaffold-row-element").resizable
          stop: (event, ui) ->
            id = $(this).attr('data-id')
            height = ui.size.height
            row = find_by_id('row', id)
            row.height = height
            $('.row-element[data-id="'+id+'"]').css('height', ui.size.height + 'px')
            $.each(site.rows[id].cells, (index, obj) ->
              obj.element.css('height', ui.size.height + 'px')
              obj.scaffold_element.css('height', ui.size.height + 'px')
            )
            ar = [{name: 'page_element[height]', value: row.height}]
            database.update(ar, row)
            invoker.resize_page()
          resize: (event, ui) ->
            id = $(this).attr('data-id')
            add_height = ui.size.height - site.rows[id].height
            invoker.resize_page(add_height)
            $('.row-element[data-id="'+id+'"]').css('height', ui.size.height + 'px')
            $.each(site.rows[id].cells, (index, obj) ->
              obj.element.css('height', ui.size.height + 'px')
              obj.scaffold_element.css('height', ui.size.height + 'px')
            )
        $('.ui-resizable-s').mousemove (event) ->
          site.scaffold.show()
        $('.ui-resizable-se').css('display', 'none')
        $('.ui-resizable-e').css('display', 'none')

      make_menu_items_draggable: () ->
        $('.sidebar_dummy').draggable
          scroll: false,
          appendTo: "cell-element-right, cell-element-left",
          revert: 'invalid',
          drag: (event, ui) ->
            site.scaffold.show()
          stop: (event, ui) ->
            site.scaffold.hide()

  site = (page) ->
    @page_id = page.id
    @row = $('.form_row')
    @element = $('.page')
    @scaffold = $('.scaffold')
    @dummy_cell = $('.dummy_cell')
    @dummy_row = $('.dummy_row')
    @scaffold_dummy_cell = $('.scaffold_dummy_cell')
    @textbox_dummy = $('.textbox_dummy')
    @image_dummy = $('.image_dummy')
    @gallery_slider_dummy = $('.gallery_slider_dummy')
    @vertical_grid_dummy = $('.vertical_grid_dummy')
    @horizontal_grid_dummy = $('.horizontal_grid_dummy')
    @centimeter_width = 10
    @primaryColor = '#990000'
    @page_height = null
    @rows = []
    @vertical_grids = []
    @horizontal_grids = []
    @cells = []
    @textboxes = []
    @images = []
    @gallery_sliders = []
    this

  marker_screen = $('.pos_marker_screen')
  marker_text = marker_screen.children('.text')
  marker = $('.pos_marker')
  menu = $('.right_sidebar')
  sidebar = $('.left_sidebar')
  screen_height = $(window).height()

  translate_settings = () ->
    site.rows = $.map(settings.rows, (e) ->
      row = new page_element.row(e)
      drawing_unit.draw_row row
      row
    )

    site.cells = $.map(settings.cells, (e) ->
      cell = new page_element.cell(e)
      drawing_unit.draw_cell cell
      cell
    )

    site.vertical_grids = $.map(settings.vertical_grids, (e) ->
      e.cell_id = find_by_server_id('cell', e.cell_id)
      vertical_grid = new page_element.vertical_grid(e)
      drawing_unit.draw_vertical_grid vertical_grid
      vertical_grid
    )

    site.horizontal_grids = $.map(settings.horizontal_grids, (e) ->
      e.cell_id = find_by_server_id('cell', e.cell_id)
      horizontal_grid = new page_element.horizontal_grid(e)
      drawing_unit.draw_horizontal_grid horizontal_grid
      horizontal_grid
    )

    site.textboxes = $.map(settings.textboxes, (e) ->
      e.cell_id = find_by_server_id('cell', e.cell_id)
      textbox = new page_element.textbox(e)
      drawing_unit.draw_textbox textbox
      textbox
    )

    site.images = $.map(settings.images, (e) ->
      e.cell_id = find_by_server_id('cell', e.cell_id)
      image = new page_element.image(e)
      drawing_unit.draw_image image
      image
    )

    site.gallery_sliders = $.map(settings.gallery_sliders, (e) ->
      e.cell_id = find_by_server_id('cell', e.cell_id)
      gallery_slider = new page_element.gallery_slider(e)
      if e.images
        gallery_slider.images = e.images.split(', ')
      drawing_unit.draw_gallery_slider gallery_slider
      gallery_slider
    )


    # console.log "rows:",site.rows
    # console.log '<------------------------------------------------------------------------------------------------------------------------>'
    # console.log "cells:",site.cells
    # console.log '<------------------------------------------------------------------------------------------------------------------------>'
    # console.log "images:",site.images
    # console.log '<------------------------------------------------------------------------------------------------------------------------>'
    # console.log "textboxes:",site.textboxes
    # console.log '<------------------------------------------------------------------------------------------------------------------------>'
    # console.log "gallery_sliders:",site.gallery_sliders
    # console.log '<------------------------------------------------------------------------------------------------------------------------>'

  initialize = () =>
    site = new site(page)
    translate_settings()
    invoker.make_scaffold_resizable()
    invoker.make_menu_items_draggable()
    invoker.make_cells_droppable()

  initialize()

  set_menu = (pos) ->
    menu.css('margin-top', pos + "px")
    sidebar.css('margin-top', pos + "px")

  relocate_destroy_btn = () ->
    btns = $('.page-element').find('.destroy').clone().addClass('trash_destroy')
    $.each(btns, (index, obj) ->
      obj = $(obj)
      editbar = $('.scaffold-element[id="'+obj.attr('id')+'"]').find('.destroy_btn_area')
      editbar.addClass('outset')
      obj.appendTo(editbar)
    )


  site.element.mouseenter (event) ->
    $('.ui-resizable-se').css('display', 'none')
    $('.ui-resizable-e').css('display', 'none')
    site.scaffold.show()
    relocate_destroy_btn()


  site.element.mouseleave (event) ->
    site.scaffold.hide()
    $('.trash_destroy').remove()

  $(document).on('click', '#change_color', (event) ->
    id = $(this).parents('.scaffold-element').attr('id')
    cell = site.cells[id]
    if cell.backgroundcolor == 'true'
      cell.element.removeClass('colored')
      cell.backgroundcolor = 'false'
      color = 'white'
      icon = 'tint'
    else
      cell.backgroundcolor = 'true'
      cell.element.addClass('colored')
      color = site.primaryColor
      icon = 'unchecked'
    $('.cell-element[data-id="' + id + '"]').css('background-color', color)
    $(this).html('<i class="icon-'+icon+'"></i>')
    ar = [{name: 'page_element[backgroundcolor]', value: cell.backgroundcolor}]
    database.update(ar, cell)
  )

  $(document).on("click", '.change_form_view', (event) ->
    status = $(this).attr('data-status')
    obj_form = $(this).parents('.modal').find('.modal-body').find('.obj_form')
    obj_present = $(this).parents('.modal').find('.modal-body').find('.obj_present')
    switch parseInt(status)
      when 0
        $(this).attr('data-status', 1)
        obj_form.hide()
        $(this).html('<i class="icon icon-edit"></i>')
        obj_present.show()
      when 1
        $(this).attr('data-status', 0)
        obj_present.hide()
        $(this).html('<i class="icon icon-eye-open"></i>')
        obj_form.show()
  )

  $(document).on('click', '.save_btn', (event) ->
    modal = $(this).parents('.modal')
    form = modal.find('form')
    action = form.attr('action')
    type = modal.attr('id').split('_form')[0]
    id = modal.data('id')
    obj = find_by_id(type, id)
    database.update(form.serializeArray(), obj)
    modal.modal('hide')
  )

  $(document).on("mouseenter", '.unchain_badge', (event) ->
    site.scaffold.show()
  )
  $(document).on('click', '.unchain_badge',  (event) ->
    event.stopPropagation()
    status = $(this).data('status')
    obj = site.rows[$(this).parents('.scaffold-row-element').data('id')]
    if status
      ar = [{name: 'page_element[split]', value: false}]
    else
      ar = [{name: 'page_element[split]', value: true}]
    database.update(ar, obj)
  )

  $(window).scroll (event) ->
    pos = $(document).scrollTop()
    set_menu pos

  $(document).on('click', '.close_modal', (event)->
    modal = $(this).parents('.modal')
    modal.modal('hide')
  );

  $(document).on('mouseenter', '.scaffold_btn', (event) ->
    site.scaffold.show()
    relocate_destroy_btn()
  )

  $(document).on('mouseleave', '.scaffold_btn', (event) ->
    $('.trash_destroy').remove()
  )

  $(document).on('mouseenter', '.ui-resizable-s', (event) ->
    site.scaffold.show()
    relocate_destroy_btn()
  )

  $(document).on('mouseleave', '.ui-resizable-s', (event) ->
    $('.trash_destroy').remove()
  )

  $(document).on('click','.destroy', (event) ->
    id = $(this).parents('.page-element').attr('id')
    type = $(this).parents('.page-element').attr('data-type')
    invoker.modals.destroy(id, type)
  )

  $(document).on('click', '.edit', (event) ->
    id = $(this).parents('.page-element').attr('id')
    type = $(this).parents('.page-element').attr('data-type')
    invoker.modals.edit(id, type)
  )

  $(document).on('click','.resize_cell', (event) ->
    id = $(this).parents('.page-element').attr('id')
    type = $(this).parents('.page-element').attr('data-type')
  )
