window.JST ||= {}

window.JST['changes_index'] = _.template("""
  <table>
    <tr>
      <th>Species</th>
      <th>Change</th>
      <th>Status</th>
      <th><button id="apply-all">Apply All</button></th>
    </tr>
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
