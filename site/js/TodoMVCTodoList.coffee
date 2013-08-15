TodoMVC.module 'TodoList', (TodoList, App, Backbone, Marionette, $, _) ->

	# TodoList Router
	# - - - - - - - -
	#
	# Handle routes to show the active versus completed todo items

	TodoList.Router = Marionette.Router.extend(

		appRouters:
			'*filter': 'filterItems'
		)

	# TodoList Controller (Mediator)
	# - - - - - - - - - - - - - - - -
	#
	# Control the workflow and logic that exists at the application
	# level, above the implementation detail of views and models

	TodoList.Controller  = ->
		@TodoList  = new App.Todos.TodoList()
		return

	_.extend TodoList.Controller.prototype, 

		# Start the app by showing the appropriate views 
		# and fetching the list of todo items, if there are any
		start: ->
			@showHeader @todoList
			@showFooter @todoList
			@showTodoList @todoList

			@todoList.fetch()
			return

		showHeader: (todoList)->
			header = new App.Layout.Header(
				collection: todoList
				)
			App.header.show header
			return

		showFooter: (todoList)->
			footer = new App.Layout.Header(
				collection: todoList
				)
			App.footer.show footer
			return

		showTodoList: (todoList)->
			App.main.show new TodoList.Views.ListView collection:todoList
			return

		# Set the filter to show complete or all items
		filterItems: (filter)->
			App.vent.trigger 'todoList:filter', filter.trim() or ''
			return

		# TodoList Initializer
		# - - - - - - - - - - - 
		#
		# Get the TodoList up and running by initializing the mediator
		# when the application is started, pulling in all of the 
		# existing todo items and displaying them.

	TodoList.addInitializer ->
		new TodoList.Router controller: controller

		controller.start()
		return

	return