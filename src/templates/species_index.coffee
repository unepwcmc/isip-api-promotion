window.JST ||= {}

window.JST['species_index'] = _.template("""
  <h1>Species</h1>
  <ul>
    <%
      var i, il, speciesModel;
      for(i = 0, il=speciesModels.length; i<il; i++){
        speciesModel = speciesModels[i];
    %>
      <li><%= view.addSubView(new Backbone.Views.SpeciesRowView({model: speciesModel})) %></li>
    <%
      }
    %>
  </ul>
""")
