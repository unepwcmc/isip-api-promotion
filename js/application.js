(function() {
  var _base, _base2, _base3, _base4, _base5, _base6, _base7, _base8, _base9,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.JST || (window.JST = {});

  window.JST['species_index'] = _.template("<h1>Species</h1>\n<ul id=\"species-list\">\n  <%\n    var i, il, speciesModel;\n    for(i = 0, il=speciesModels.length; i<il; i++){\n      speciesModel = speciesModels[i];\n  %>\n    <%= view.addSubView(new Backbone.Views.SpeciesRowView({model: speciesModel})) %>\n  <%\n    }\n  %>\n</ul>");

  window.Backbone || (window.Backbone = {});

  (_base = window.Backbone).Views || (_base.Views = {});

  Backbone.Views.SpeciesIndexView = (function(_super) {

    __extends(SpeciesIndexView, _super);

    function SpeciesIndexView() {
      this.render = __bind(this.render, this);
      SpeciesIndexView.__super__.constructor.apply(this, arguments);
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

  (_base2 = window.Backbone).Models || (_base2.Models = {});

  window.Backbone.Models.Species = (function(_super) {

    __extends(Species, _super);

    function Species() {
      Species.__super__.constructor.apply(this, arguments);
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

  (_base3 = window.Backbone).Collections || (_base3.Collections = {});

  Backbone.Collections.SpeciesCollection = (function(_super) {

    __extends(SpeciesCollection, _super);

    function SpeciesCollection() {
      SpeciesCollection.__super__.constructor.apply(this, arguments);
    }

    SpeciesCollection.prototype.model = Backbone.Models.Species;

    SpeciesCollection.prototype.url = "data/species.json";

    return SpeciesCollection;

  })(Backbone.Collection);

  window.JST || (window.JST = {});

  window.JST['species_row'] = _.template("<%= model.get('full_name') %>\n<span class=\"state\">\n  <div class=\"appendix <%= model.get('current_listing') %>\"><%= model.get('current_listing') %></div>\n  <% if(pendingChangeCount > 0) { %>\n    <div class=\"notification\"><%= pendingChangeCount %></div>\n  <% } %>\n</span>");

  window.Backbone || (window.Backbone = {});

  (_base4 = window.Backbone).Views || (_base4.Views = {});

  Backbone.Views.SpeciesRowView = (function(_super) {

    __extends(SpeciesRowView, _super);

    function SpeciesRowView() {
      this.render = __bind(this.render, this);
      SpeciesRowView.__super__.constructor.apply(this, arguments);
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

  (_base5 = window.Backbone).Models || (_base5.Models = {});

  window.Backbone.Models.Change = (function(_super) {

    __extends(Change, _super);

    function Change() {
      Change.__super__.constructor.apply(this, arguments);
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
      this.set({
        previousListing: this.getSpecies().get('current_listing')
      });
      return this.getSpecies().set({
        current_listing: this.get('species_listing_name')
      });
    };

    Change.prototype.undoChange = function() {
      this.set({
        applied: false
      });
      return this.getSpecies().set({
        current_listing: this.get('previousListing')
      });
    };

    Change.prototype.toggleChange = function() {
      this.set({
        applied: !this.get('applied')
      });
      if (this.get('applied')) {
        this.set({
          previousListing: this.getSpecies().get('current_listing')
        });
        return this.getSpecies().set({
          current_listing: this.get('species_listing_name')
        });
      } else {
        return this.getSpecies().set({
          current_listing: this.get('previousListing')
        });
      }
    };

    return Change;

  })(Backbone.Model);

  window.Backbone || (window.Backbone = {});

  (_base6 = window.Backbone).Collections || (_base6.Collections = {});

  Backbone.Collections.ChangeCollection = (function(_super) {

    __extends(ChangeCollection, _super);

    function ChangeCollection() {
      ChangeCollection.__super__.constructor.apply(this, arguments);
    }

    ChangeCollection.prototype.model = Backbone.Models.Change;

    ChangeCollection.prototype.url = "data/changes.json";

    ChangeCollection.prototype.applyAll = function() {
      return this.each(function(model) {
        return model.applyChange();
      });
    };

    ChangeCollection.prototype.undoAll = function() {
      return this.each(function(model) {
        return model.undoChange();
      });
    };

    ChangeCollection.prototype.toggleAll = function() {
      return this.each(function(model) {
        return model.toggleChange();
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

  window.JST['changes_index'] = _.template("<div class=\"row changes-header\">\n  <div class=\"left\">\n    <h2>Species</h2>\n  </div>\n  <div class=\"right\">\n    <h2>CoP15 Changes</h2>\n    <% if (changeList.outstandingChanges().length > 0) { %>\n      <a id=\"apply-all\" class=\"btn\">Apply All</a>\n    <% } else { %>\n      <a id=\"undo-all\" class=\"btn activated\">Undo All</a>\n    <% } %>\n  </div>\n</div>\n\n<div class=\"row changes\">\n  <div class=\"changes-table\">\n    <table>\n      <%\n        var i, il, changeModel;\n        var changeModels = changeList.models;\n        for(i = 0, il=changeModels.length; i<il; i++){\n          changeModel = changeModels[i];\n      %>\n        <%= view.addSubView(new Backbone.Views.ChangeRowView({model: changeModel})) %>\n      <%\n        }\n      %>\n    </table>\n  </div>\n  <div class=\"row changes-table-footer\">\n    <div class=\"left\">\n      Total number of species\n      <span class=\"pull-right\"><%= speciesCount %></span>\n    </div>\n    <div class=\"right\">\n      Total Number of Listing Changes\n      <span class=\"pull-right\"><%= changeModels.length %></span>\n    </div>\n  </div>\n</div>");

  window.Backbone || (window.Backbone = {});

  (_base7 = window.Backbone).Views || (_base7.Views = {});

  Backbone.Views.ChangesIndexView = (function(_super) {

    __extends(ChangesIndexView, _super);

    function ChangesIndexView() {
      this.render = __bind(this.render, this);
      ChangesIndexView.__super__.constructor.apply(this, arguments);
    }

    ChangesIndexView.prototype.template = JST['changes_index'];

    ChangesIndexView.prototype.events = {
      "click #apply-all": "applyAll",
      "click #undo-all": "undoAll"
    };

    ChangesIndexView.prototype.initialize = function(options) {
      var _this = this;
      this.changeList = options.changeList;
      this.listenTo(this.changeList, 'sync', this.render);
      this.listenTo(this.changeList, 'change', function() {
        _this.render();
        return _this.stopListening(_this.changeList);
      });
      this.speciesList = options.speciesList;
      this.listenTo(this.speciesList, 'sync', this.render);
      this.listenTo(this.speciesList, 'change', function() {
        _this.render();
        return _this.stopListening(_this.speciesList, 'change');
      });
      return this.render();
    };

    ChangesIndexView.prototype.render = function() {
      this.closeSubViews();
      this.$el.html(this.template({
        view: this,
        changeList: this.changeList,
        speciesCount: this.speciesList.length
      }));
      this.renderSubViews();
      return this;
    };

    ChangesIndexView.prototype.undoAll = function(e) {
      this.changeList.undoAll();
      return this.render();
    };

    ChangesIndexView.prototype.applyAll = function(e) {
      this.changeList.applyAll();
      return this.render();
    };

    ChangesIndexView.prototype.onClose = function() {
      this.stopListening(this.changeList, 'sync', this.render);
      this.stopListening(this.speciesList);
      return this.closeSubViews();
    };

    return ChangesIndexView;

  })(Backbone.Diorama.NestingView);

  window.JST || (window.JST = {});

  window.JST['changes_row_addition'] = _.template("<td>\n  <%= speciesName %>\n  <span class=\"author\"><%= speciesAuthor %></span>\n</td>\n<td>\n  <div class=\"appendix-change <% if (change.get('applied')){ %>move<% } %>\">\n    <% if (change.get('previousListing') != undefined) { %>\n      <div class=\"icon <%= change.get('previousListing').toLowerCase() %>\"></div>\n    <% } else { %>\n      <div class=\"icon <%= speciesListing.toLowerCase() %>\"></div>\n    <% } %>\n    <div class=\"icon <%= change.get('species_listing_name') %>\"></div>\n  </div>\n  <div class=\"control\">\n    <% if (!change.get('applied')) { %>\n      <a class=\"btn\">Apply</a>\n    <% } else { %>\n      <a class=\"btn activated\">Undo</a>\n    <% } %>\n  </div>\n</td>");

  window.JST || (window.JST = {});

  window.JST['changes_row_annotation'] = _.template("<td>\n  <%= speciesName %>\n  <span class=\"author\"><%= speciesAuthor %></span>\n</td>\n<td>\n  <div class=\"new-annotation <% if (change.get('applied')) { %>done<% } %>\">\n    <div>\n      New or updated annotations\n    </div>\n  </div>\n  <div class=\"control\">\n    <% if (!change.get('applied')) { %>\n      <a class=\"btn\">Apply</a>\n    <% } else { %>\n      <a class=\"btn activated\">Undo</a>\n    <% } %>\n  </div>\n</td>");

  window.JST || (window.JST = {});

  window.JST['changes_row_deletion'] = _.template("<td>\n  <%= speciesName %>\n  <span class=\"author\"><%= speciesAuthor %></span>\n</td>\n<td>\n  <div class=\"appendix-change <% if (change.get('applied')){ %>move<% } %>\">\n    <% if (change.get('previousListing') != undefined) { %>\n      <div class=\"icon <%= change.get('previousListing').toLowerCase() %>\"></div>\n    <% } else { %>\n      <div class=\"icon <%= speciesListing.toLowerCase() %>\"></div>\n    <% } %>\n    <div class=\"icon deletion\"></div>\n  </div>\n  <div class=\"control\">\n    <% if (!change.get('applied')) { %>\n      <a class=\"btn\">Apply</a>\n    <% } else { %>\n      <a class=\"btn activated\">Undo</a>\n    <% } %>\n  </div>\n</td>");

  window.JST || (window.JST = {});

  window.JST['changes_row_new'] = _.template("<% if (change.get('applied')) { %>\n  <td>\n    <div class=\"fade-in\">\n      <%= speciesName %>\n      <span class=\"author\"><%= speciesAuthor %></span>\n    </div>\n<% } else { %>\n  <td class=\"empty\">\n    New species to be added\n<% } %>\n  </td>\n<td>\n  <div class=\"new-species <% if (change.get('applied')){ %>move<% } %>\">\n    <div>\n      <%= speciesName %>\n      <span class=\"author\"><%= speciesAuthor %></span>\n    </div>\n  </div>\n  <div class=\"control\">\n    <% if (!change.get('applied')) { %>\n      <a class=\"btn\">Apply</a>\n    <% } else { %>\n      <a class=\"btn activated\">Undo</a>\n    <% } %>\n  </div>\n</td>");

  window.Backbone || (window.Backbone = {});

  (_base8 = window.Backbone).Views || (_base8.Views = {});

  Backbone.Views.ChangeRowView = (function(_super) {

    __extends(ChangeRowView, _super);

    function ChangeRowView() {
      this.render = __bind(this.render, this);
      ChangeRowView.__super__.constructor.apply(this, arguments);
    }

    ChangeRowView.prototype.tagName = 'tr';

    ChangeRowView.prototype.events = {
      "click .btn": "toggleChange"
    };

    ChangeRowView.prototype.initialize = function(options) {
      this.model = options.model;
      this.template = JST["changes_row_" + (this.model.get('change_type').toLowerCase())];
      return this.render();
    };

    ChangeRowView.prototype.render = function() {
      var speciesAuthor, speciesListing, speciesName;
      if (this.model.get('applied')) {
        this.$el.addClass('applied');
      } else {
        this.$el.removeClass('applied');
      }
      if (this.model.getSpecies()) {
        speciesName = this.model.getSpecies().get('full_name');
        speciesListing = this.model.getSpecies().get('current_listing');
        speciesAuthor = this.model.getSpecies().get('author_year');
      } else {
        speciesName = 'Unknown species';
        speciesListing = 'Unlisted';
        speciesAuthor = "";
      }
      return this.$el.html(this.template({
        cid: this.cid,
        change: this.model,
        speciesName: speciesName,
        speciesListing: speciesListing,
        speciesAuthor: speciesAuthor
      }));
    };

    ChangeRowView.prototype.toggleChange = function(e) {
      console.log(this.model.get('change_type'));
      this.model.toggleChange();
      return this.render();
    };

    ChangeRowView.prototype.onClose = function() {};

    return ChangeRowView;

  })(Backbone.View);

  window.JST || (window.JST = {});

  window.JST['stats'] = _.template("<div class=\"col1\">\n  <h3>Automatic Update</h3>\n\n  <h4>Listing Changes</h4>\n  <div class=\"large-number-grid\">\n    <%= changesLeftToApply %>\n    <span>Out Of <%= totalChanges %></span>\n  </div>\n\n  <h4>Estimated Time</h4>\n  <div class=\"time-grid\">\n    <div><%= apiTimeRemaining.days %></div>\n    <span class=\"hours\"><%= apiTimeRemaining.hours %></span>\n    <span class=\"mins\"><%= apiTimeRemaining.minutes %></span>\n  </div>\n</div>\n\n<div class=\"col2\">\n  <h3>Manual Update</h3>\n\n  <h4>Listing Changes</h4>\n  <div class=\"large-number-grid\">\n    <%= manualOutstandingChanges %>\n    <span>Out Of <%= totalChanges %></span>\n  </div>\n\n  <h4>Estimated Time</h4>\n  <div class=\"time-grid\">\n    <div><%= manualTimeRemaining.days %></div>\n    <span class=\"hours\"><%= manualTimeRemaining.hours %></span>\n    <span class=\"mins\"><%= manualTimeRemaining.minutes %></span>\n  </div>\n</div>\n\n<div class=\"col3\">\n  <h3>Time Saved</h3>\n  <div class=\"time-grid time-saved\">\n    <div><%= timeSaved.days %></div>\n    <span class=\"hours\"><%= timeSaved.hours %></span>\n    <span class=\"mins\"><%= timeSaved.minutes %></span>\n  </div>\n</div>");

  window.Backbone || (window.Backbone = {});

  (_base9 = window.Backbone).Views || (_base9.Views = {});

  Backbone.Views.StatsView = (function(_super) {

    __extends(StatsView, _super);

    function StatsView() {
      this.updateTimers = __bind(this.updateTimers, this);
      this.render = __bind(this.render, this);
      StatsView.__super__.constructor.apply(this, arguments);
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
        totalChanges: this.changeList.models.length,
        apiTimeRemaining: this.secondsAsTime(unappliedChanges),
        appliedChanges: appliedChanges,
        timeSaved: this.secondsAsTime(appliedChanges * this.taskTime - appliedChanges)
      }));
    };

    StatsView.prototype.taskTime = 600;

    StatsView.prototype.resetManualTimer = function() {
      this.manualTimeRemaining = this.changeList.models.length * this.taskTime;
      this.timeSpent = 0;
      if (this.timer != null) clearTimeout(this.timer);
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
