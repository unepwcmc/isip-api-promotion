window.JST ||= {}

window.JST['changes_index'] = _.template("""
  <h1>Changes</h1>
  <ul id="change-list">
    <%
      var i, il, changeModel;
      for(i = 0, il=changeModels.length; i<il; i++){
        changeModel = changeModels[i];
    %>
      <%= view.addSubView(new Backbone.Views.ChangeRowView({model: changeModel})) %>
    <%
      }
    %>
  </ul>
""")
