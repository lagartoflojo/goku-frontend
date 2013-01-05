App.Router.map (match) ->
  match('/').to('index')
  match('/collections').to 'allCollections', (match) ->
    match('/').to 'collections'
    match('/:collection_id').to 'collection'
    match('/new').to 'newCollection'

App.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'collections'

App.CollectionsRoute = Ember.Route.extend
  model: ->
    App.Collection.find()

App.CollectionRoute = Ember.Route.extend
  model: (params) ->
    App.Collection.find(params.collection_id)

App.NewCollectionRoute = Ember.Route.extend
  model: (params) ->
    Ember.Object.create()



    # goHome: Ember.Route.transitionTo('collections.index')