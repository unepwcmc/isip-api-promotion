// Generated by CoffeeScript 1.4.0
(function() {
  var _base, _base1, _base2, _base3, _base4, _base5, _base6, _base7, _base8,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.JST || (window.JST = {});

  window.JST['species_index'] = _.template("<h1>Species</h1>\n<ul id=\"species-list\">\n  <%\n    var i, il, speciesModel;\n    for(i = 0, il=speciesModels.length; i<il; i++){\n      speciesModel = speciesModels[i];\n  %>\n    <%= view.addSubView(new Backbone.Views.SpeciesRowView({model: speciesModel})) %>\n  <%\n    }\n  %>\n</ul>");

  window.Backbone || (window.Backbone = {});

  (_base = window.Backbone).Views || (_base.Views = {});

  Backbone.Views.SpeciesIndexView = (function(_super) {

    __extends(SpeciesIndexView, _super);

    function SpeciesIndexView() {
      this.render = __bind(this.render, this);
      return SpeciesIndexView.__super__.constructor.apply(this, arguments);
    }

    SpeciesIndexView.prototype.template = JST['species_index'];

    SpeciesIndexView.prototype.initialize = function(options) {
      this.speciesList = options.speciesList;
      this.listenTo(this.speciesList, 'sync', this.render);
      this.listenTo(ISIP.changeList, 'sync', this.render);
      return this.render();
    };

    SpeciesIndexView.prototype.render = function() {
      this.closeSubViews();
      this.$el.html(this.template({
        view: this,
        speciesModels: this.speciesList.models
      }));
      this.renderSubViews();
      return this;
    };

    SpeciesIndexView.prototype.onClose = function() {
      this.closeSubViews();
      this.stopListening(this.speciesList, 'sync', this.render);
      return this.stopListening(ISIP.changeList, 'sync', this.render);
    };

    return SpeciesIndexView;

  })(Backbone.Diorama.NestingView);

  (_base1 = window.Backbone).Models || (_base1.Models = {});

  window.Backbone.Models.Species = (function(_super) {

    __extends(Species, _super);

    function Species() {
      return Species.__super__.constructor.apply(this, arguments);
    }

    Species.prototype.pendingChangeCount = function() {
      return ISIP.changeList.where({
        taxon_concept_id: this.get('id'),
        applied: false
      }).length;
    };

    return Species;

  })(Backbone.Model);

  window.Backbone || (window.Backbone = {});

  (_base2 = window.Backbone).Collections || (_base2.Collections = {});

  Backbone.Collections.SpeciesCollection = (function(_super) {

    __extends(SpeciesCollection, _super);

    function SpeciesCollection() {
      return SpeciesCollection.__super__.constructor.apply(this, arguments);
    }

    SpeciesCollection.prototype.model = Backbone.Models.Species;

    SpeciesCollection.prototype.url = "data/species.json";

    SpeciesCollection.prototype.parse = function(data) {
      return data[0].animalia.concat(data[0].animalia);
    };

    return SpeciesCollection;

  })(Backbone.Collection);

  window.JST || (window.JST = {});

  window.JST['species_row'] = _.template("<%= model.get('full_name') %>\n<span class=\"state\">\n  <div class=\"appendix <%= model.get('current_listing') %>\"><%= model.get('current_listing') %></div>\n  <% if(pendingChangeCount > 0) { %>\n    <div class=\"notification\"><%= pendingChangeCount %></div>\n  <% } %>\n</span>");

  window.Backbone || (window.Backbone = {});

  (_base3 = window.Backbone).Views || (_base3.Views = {});

  Backbone.Views.SpeciesRowView = (function(_super) {

    __extends(SpeciesRowView, _super);

    function SpeciesRowView() {
      this.render = __bind(this.render, this);
      return SpeciesRowView.__super__.constructor.apply(this, arguments);
    }

    SpeciesRowView.prototype.tagName = 'li';

    SpeciesRowView.prototype.template = JST['species_row'];

    SpeciesRowView.prototype.initialize = function(options) {
      this.model = options.model;
      this.listenTo(this.model, 'change', this.render);
      this.listenTo(this.model, 'change', this.highlight);
      return this.render();
    };

    SpeciesRowView.prototype.render = function() {
      return this.$el.html(this.template({
        model: this.model,
        pendingChangeCount: this.model.pendingChangeCount()
      }));
    };

    SpeciesRowView.prototype.highlight = function() {
      return this.$el.fadeTo('slow', 0.5).fadeTo('slow', 1);
    };

    SpeciesRowView.prototype.onClose = function() {
      this.stopListening(this.model, 'change', this.render);
      return this.stopListening(this.model, 'change', this.highlight);
    };

    return SpeciesRowView;

  })(Backbone.View);

  (_base4 = window.Backbone).Models || (_base4.Models = {});

  window.Backbone.Models.Change = (function(_super) {

    __extends(Change, _super);

    function Change() {
      return Change.__super__.constructor.apply(this, arguments);
    }

    Change.prototype.initialize = function() {
      return this.set({
        applied: false
      });
    };

    Change.prototype.getSpecies = function() {
      if (this.species != null) {
        return this.species;
      } else {
        return this.species = ISIP.speciesList.where({
          id: this.get('taxon_concept_id')
        })[0];
      }
    };

    Change.prototype.applyChange = function() {
      this.set({
        applied: true
      });
      return this.getSpecies().set({
        current_listing: this.get('species_listing_name')
      });
    };

    return Change;

  })(Backbone.Model);

  window.Backbone || (window.Backbone = {});

  (_base5 = window.Backbone).Collections || (_base5.Collections = {});

  Backbone.Collections.ChangeCollection = (function(_super) {

    __extends(ChangeCollection, _super);

    function ChangeCollection() {
      return ChangeCollection.__super__.constructor.apply(this, arguments);
    }

    ChangeCollection.prototype.model = Backbone.Models.Change;

    ChangeCollection.prototype.url = "data/changes.json";

    ChangeCollection.prototype.applyAll = function() {
      return this.each(function(model) {
        return model.applyChange();
      });
    };

    ChangeCollection.prototype.outstandingChanges = function() {
      return this.where({
        applied: false
      });
    };

    ChangeCollection.prototype.appliedChanges = function() {
      return this.where({
        applied: true
      });
    };

    return ChangeCollection;

  })(Backbone.Collection);

  window.JST || (window.JST = {});

  window.JST['changes_index'] = _.template("<table>\n  <tr>\n    <th>Species</th>\n    <th>Change</th>\n    <th>Status</th>\n    <th><button id=\"apply-all\">Apply All</button></th>\n  </tr>\n  <%\n    var i, il, changeModel;\n    for(i = 0, il=changeModels.length; i<il; i++){\n      changeModel = changeModels[i];\n  %>\n    <%= view.addSubView(new Backbone.Views.ChangeRowView({model: changeModel})) %>\n  <%\n    }\n  %>\n</ul>");

  window.Backbone || (window.Backbone = {});

  (_base6 = window.Backbone).Views || (_base6.Views = {});

  Backbone.Views.ChangesIndexView = (function(_super) {

    __extends(ChangesIndexView, _super);

    function ChangesIndexView() {
      this.render = __bind(this.render, this);
      return ChangesIndexView.__super__.constructor.apply(this, arguments);
    }

    ChangesIndexView.prototype.template = JST['changes_index'];

    ChangesIndexView.prototype.events = {
      "click #apply-all": "applyAll"
    };

    ChangesIndexView.prototype.initialize = function(options) {
      this.changeList = options.changeList;
      this.listenTo(this.changeList, 'sync', this.render);
      this.speciesList = options.speciesList;
      this.listenTo(this.speciesList, 'sync', this.render);
      this.listenTo(this.speciesList, 'change', this.render);
      return this.render();
    };

    ChangesIndexView.prototype.render = function() {
      this.closeSubViews();
      this.$el.html(this.template({
        view: this,
        changeModels: this.changeList.models
      }));
      this.renderSubViews();
      return this;
    };

    ChangesIndexView.prototype.applyAll = function() {
      return this.changeList.applyAll();
    };

    ChangesIndexView.prototype.onClose = function() {
      this.stopListening(this.changeList, 'sync', this.render);
      this.stopListening(this.speciesList);
      return this.closeSubViews();
    };

    return ChangesIndexView;

  })(Backbone.Diorama.NestingView);

  window.JST || (window.JST = {});

  window.JST['changes_row'] = _.template("<td>\n  <%= speciesName %>\n</td>\n<td>\n  <span class=\"appendix <%= speciesListing %>\"><%= speciesListing %></span> ->\n  <span class=\"appendix <%= change.get('species_listing_name') %>\"><%= change.get('species_listing_name')%></span>\n</td>\n<td>\n  <%= change.get('applied') ? 'Applied' : 'Not Yet Applied' %>\n</td>\n<td>\n  <button>Apply</button>\n</td>");

  window.Backbone || (window.Backbone = {});

  (_base7 = window.Backbone).Views || (_base7.Views = {});

  Backbone.Views.ChangeRowView = (function(_super) {

    __extends(ChangeRowView, _super);

    function ChangeRowView() {
      this.render = __bind(this.render, this);
      return ChangeRowView.__super__.constructor.apply(this, arguments);
    }

    ChangeRowView.prototype.tagName = 'tr';

    ChangeRowView.prototype.template = JST['changes_row'];

    ChangeRowView.prototype.events = {
      "click button": "applyChange"
    };

    ChangeRowView.prototype.initialize = function(options) {
      this.model = options.model;
      this.listenTo(this.model, 'change', this.render);
      return this.render();
    };

    ChangeRowView.prototype.render = function() {
      var speciesListing, speciesName;
      if (this.model.get('applied')) {
        this.$el.addClass('applied');
      } else {
        this.$el.removeClass('applied');
      }
      if (this.model.getSpecies()) {
        speciesName = this.model.getSpecies().get('full_name');
        speciesListing = this.model.getSpecies().get('current_listing');
      } else {
        speciesName = 'Unknown species';
        speciesListing = 'Unlisted';
      }
      return this.$el.html(this.template({
        change: this.model,
        speciesName: speciesName,
        speciesListing: speciesListing
      }));
    };

    ChangeRowView.prototype.applyChange = function() {
      return this.model.applyChange();
    };

    ChangeRowView.prototype.onClose = function() {};

    return ChangeRowView;

  })(Backbone.View);

  window.JST || (window.JST = {});

  window.JST['stats'] = _.template("<ul class=\"stats\">\n  <li>\n    <h4>MANUAL UPDATE</h4>\n    <h5>CHANGES TO APPLY</h5>\n    <span class=\"value\"><%= manualOutstandingChanges %></span>\n    <h5>ESTIMATED TIME REMAINING</h5>\n    <span class=\"value\"><%= manualTimeRemaining.days %> days, <%= manualTimeRemaining.hours %> hours, <%= manualTimeRemaining.minutes %> minutes</span>\n  </li>\n  <li>\n    <h4>WCMC API</h4>\n    <h5>API CHANGES LEFT TO APPLY</h5>\n    <span class=\"value\"><%= changesLeftToApply %></span>\n    <h5>ESTIMATED TIME REMAINING</h5>\n    <span class=\"value\"><%= apiTimeRemaining.minutes %> hours, <%= apiTimeRemaining.minutes %> minutes, <%= apiTimeRemaining.seconds %> seconds</span>\n  </li>\n  <li>\n    <h4>WCMC API SAVED</h4>\n    <p>Over <%= appliedChanges %> changes, you saved: </p>\n    <span class=\"value\"><%= timeSaved.hours %> hours, <%= timeSaved.minutes %> minutes</span>\n  </li>\n</ul>");

  window.Backbone || (window.Backbone = {});

  (_base8 = window.Backbone).Views || (_base8.Views = {});

  Backbone.Views.StatsView = (function(_super) {

    __extends(StatsView, _super);

    function StatsView() {
      this.updateTimers = __bind(this.updateTimers, this);

      this.render = __bind(this.render, this);
      return StatsView.__super__.constructor.apply(this, arguments);
    }

    StatsView.prototype.template = JST['stats'];

    StatsView.prototype.initialize = function(options) {
      this.changeList = options.changeList;
      this.listenTo(this.changeList, 'sync', this.resetManualTimer);
      this.listenTo(this.changeList, 'change', this.render);
      return this.resetManualTimer();
    };

    StatsView.prototype.render = function() {
      var appliedChanges, unappliedChanges;
      appliedChanges = this.changeList.appliedChanges().length;
      unappliedChanges = this.changeList.models.length - appliedChanges;
      return this.$el.html(this.template({
        manualOutstandingChanges: this.roundUp(this.manualTimeRemaining / this.taskTime),
        manualTimeRemaining: this.secondsAsTime(this.manualTimeRemaining),
        changesLeftToApply: unappliedChanges,
        apiTimeRemaining: this.secondsAsTime(unappliedChanges),
        appliedChanges: appliedChanges,
        timeSaved: this.secondsAsTime(appliedChanges * this.taskTime - appliedChanges)
      }));
    };

    StatsView.prototype.taskTime = 3600;

    StatsView.prototype.resetManualTimer = function() {
      this.manualTimeRemaining = this.changeList.models.length * this.taskTime;
      this.timeSpent = 0;
      if (this.timer != null) {
        clearTimeout(this.timer);
      }
      return this.timer = setTimeout(this.updateTimers, 1000);
    };

    StatsView.prototype.updateTimers = function() {
      if (this.manualTimeRemaining > 0) {
        this.manualTimeRemaining = this.manualTimeRemaining - 1;
      }
      this.timeSpent = this.timeSpent + 1;
      this.render();
      return this.timer = setTimeout(this.updateTimers, 1000);
    };

    StatsView.prototype.roundDown = function(number) {
      return Math.round(number - 0.5);
    };

    StatsView.prototype.roundUp = function(number) {
      return Math.round(number + 0.5);
    };

    StatsView.prototype.secondsAsTime = function(seconds) {
      var secondsInHour, secondsInMinute, secondsInWorkDay, times;
      times = {};
      secondsInMinute = 60;
      secondsInHour = secondsInMinute * 60;
      secondsInWorkDay = secondsInHour * 7.5;
      times.days = this.roundDown(seconds / secondsInWorkDay);
      times.hours = this.roundDown((seconds - (times.days * secondsInWorkDay)) / secondsInHour);
      times.minutes = this.roundDown((seconds - ((times.hours * secondsInHour) + (times.days * secondsInWorkDay))) / secondsInMinute);
      times.seconds = this.roundDown(seconds - ((times.minutes * secondsInMinute) + (times.hours * secondsInHour) + (times.days * secondsInWorkDay)));
      return times;
    };

    StatsView.prototype.onClose = function() {
      return this.stopListening(this.changeList, 'sync', this.render);
    };

    return StatsView;

  })(Backbone.View);

}).call(this);
