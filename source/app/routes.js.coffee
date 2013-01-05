App.Router = Ember.Router.extend
  enableLogging: true
  root: Ember.Route.extend
    goHome: Ember.Route.transitionTo('collections.index')

    collections: Ember.Route.extend
      route: '/'
      connectOutlets: (router, context) ->

      index: Ember.Route.extend
        route: '/'
        show: Ember.Route.transitionTo('collections.show')
        new: Ember.Route.transitionTo('collections.new')
        connectOutlets: (router, context) ->
          router.get('applicationController').connectOutlet('collections', App.Collection.find())

      show: Ember.Route.extend
        route: '/collection/:id'
        connectOutlets: (router, collection) ->
          router.get('applicationController')
            .connectOutlet('collection', App.Collection.find(collection.get('id')))
        serialize: (router, context) ->
          id: context.get('id')
        deserialize: (router, params) ->
          App.Collection.find(params.id)

      new: Ember.Route.extend
        route: '/collections/new'
        connectOutlets: (router, collection) ->
          router.get('applicationController')
            .connectOutlet 'editCollection', Ember.Object.create()