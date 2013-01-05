#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./templates
#= require      ./routes

jQuery.ajaxSetup
  headers:
    "X-Requested-With": "XMLHttpRequest"

window.App = Ember.Application.create()

App.Store = DS.Store.extend
  revision: 11
  adapter: DS.RESTAdapter.create
    url: 'http://192.168.1.120:3000'

App.CollectionsController = Ember.ArrayController.extend()
App.CollectionsView = Ember.View.extend
  templateName: 'collections/index'

App.CollectionController = Ember.ObjectController.extend()
App.CollectionView = Ember.View.extend
  templateName: 'collections/show'

  mouseEnter: ->
    console.log 'entered!'

App.NewCollectionController = Ember.ObjectController.extend
  placeholder: Ember.Object.create()
  save: ->
    collection = App.Collection.createRecord
      name:        @placeholder.get('name')
      description: @placeholder.get('description')
    @get('store').commit()
    @get('target').transitionTo 'collection', collection

App.NewCollectionView = Ember.View.extend
  templateName: 'collections/edit'

  didInsertElement: ->
    console.log "I'm in!"

App.EditCollectionController = Ember.ObjectController.extend
  save: ->
    collection = @get('content')
    collection.merge(@get('placeholder'))
    @get('store').commit()
    @get('target').transitionTo 'collection', @get('content')

App.EditCollectionView = Ember.View.extend
  templateName: 'collections/edit'

App.HomeNavigationController = Ember.ObjectController.extend()
App.HomeNavigationView = Ember.View.extend
  templateName: 'home_navigation'

App.Collection = DS.Model.extend
  name:        DS.attr('string')
  description: DS.attr('string')
  items:       DS.hasMany('App.Item')

  reverseMerge: (source) ->
    @eachAttribute (attr) =>
      source.set attr, @get(attr)
    source

  merge: (source) ->
    @eachAttribute (attr) =>
      @set attr, source.get(attr)
    @

  objectCopy: ->
    @reverseMerge(Ember.Object.create())


App.Item = DS.Model.extend
  name:        DS.attr('string')
  description: DS.attr('string')
  collection:  DS.belongsTo('App.Collection')

App.LazyTextField = Ember.TextField.extend
  valueBinding: Ember.Binding.oneWay('value')

App.LazyTextArea = Ember.TextArea.extend
  valueBinding: Ember.Binding.oneWay('source')
