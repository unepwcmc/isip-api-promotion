window.JST ||= {}

window.JST['changes_index'] = _.template("""
  <div class="header">
    <h1>Changes</h1>
    <button id="apply-all">Apply All</button>
  </div>
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
