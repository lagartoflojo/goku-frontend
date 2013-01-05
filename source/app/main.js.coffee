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
  revision: 10
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

App.EditCollectionController = Ember.ObjectController.extend
  saveCollection: ->
    App.Collection.createRecord
      name:        @get('name')
      description: @get('description')
    @get('store').commit()

App.EditCollectionView = Ember.View.extend
  templateName: 'collections/edit'

  didInsertElement: ->
    console.log "I'm in!"


App.HomeNavigationController = Ember.ObjectController.extend()
App.HomeNavigationView = Ember.View.extend
  templateName: 'home_navigation'

App.Collection = DS.Model.extend
    name:        DS.attr('string')
    description: DS.attr('string')
    items:       DS.hasMany('App.Item')

App.Item = DS.Model.extend
    name:        DS.attr('string')
    description: DS.attr('string')
    collection:  DS.belongsTo('App.Collection')
