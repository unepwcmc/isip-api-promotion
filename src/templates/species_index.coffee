window.JST ||= {}

window.JST['species_index'] = _.template("""
  <h1>Species</h1>
  <ul id="species-list">
    <%
      var i, il, speciesModel;
      for(i = 0, il=speciesModels.length; i<il; i++){
        speciesModel = speciesModels[i];
    %>
      <%= view.addSubView(new Backbone.Views.SpeciesRowView({model: speciesModel})) %>
    <%
      }
    %>
  </ul>
""")
