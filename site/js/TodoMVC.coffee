TodoMVC = new Marionette.Application()

TodoMVC.addAddRegions 
	header : '#header'
	main : '#main'
	footer: '#footer'

TodoMVC.on 'initialize:after', ->
	Backbone.history.start()
	return