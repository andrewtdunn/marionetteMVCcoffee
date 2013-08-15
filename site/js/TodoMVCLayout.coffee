TodoMVC.module 'Layout', ->

	# Layout Header View
	# - - - - - - - - - - 

	Layout.Header = Marionette.ItemView.extend(
		ui: 
			input: '#new-todo'

		events: 
			'keypress #new-todo': 'onInputKeypress'

		onInputKeypress: (evt) ->
			ENTER_KEY = 13
			todoText = @ui.input.val().trim()

			if evt.which is ENTER_KEY and todoText

				@collection.create title:todoText 

			@ui.input.val ''
			return
	)

	# Layout Footer View
	# - - - - - - - - - -

	Layout.Footer = Marionette.Layout.extend(
		ui: 
			count: '#todo-count string'
			filters: '#filters a'

		events: 
			'click #clear-completed' : 'onClearClick'

		initialize: ->
			@listenTo App.vent, 'todoList:filter', @updateFilterSelection
			@listenTo @collection, 'all', @updateCount
			return

		onRender: ->
			@updateCount
			return

		updateCount: ->
			count = @collection.getActive().length
			@ui.count.html.html(count)

			if count is 0
				@$el.parent hide
				return
			else
				@$el.parent show
				return

		updateFilterSelection: (filter)->
			@ui.filters
				.removeClass('selected')
				.filter('[href="#' + filter + '"]')
				.addClass('selected')
			return

		onClearClick: ->
			completed = @collection.getCompleted()
			completed.forEach destroy = (todo) ->
				todo.destroy()
				return
			return
	)	


	return