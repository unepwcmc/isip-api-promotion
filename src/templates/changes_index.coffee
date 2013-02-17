window.JST ||= {}

window.JST['changes_index'] = _.template("""
  <div class="row changes-header">
    <div class="left">
      <h2>Species</h2>
    </div>
    <div class="right">
      <h2>C<span>o</span>P15 Changes</h2>
      <% if (changeList.outstandingChanges().length > 0) { %>
        <a id="apply-all" class="btn">Apply All</a>
      <% } else { %>
        <a id="undo-all" class="btn activated">Undo All</a>
      <% } %>
    </div>
  </div>

  <div class="row changes">
    <div class="changes-table">
      <table>
        <%
          var i, il, changeModel;
          var changeModels = changeList.models;
          for(i = 0, il=changeModels.length; i<il; i++){
            changeModel = changeModels[i];
        %>
          <%= view.addSubView(new Backbone.Views.ChangeRowView({model: changeModel})) %>
        <%
          }
        %>
      </table>
    </div>
    <div class="row changes-table-footer">
      <div class="left">
        Total number of species
        <span class="pull-right"><%= speciesCount %></span>
      </div>
      <div class="right">
        Total Number of Listing Changes
        <span class="pull-right"><%= changeModels.length %></span>
      </div>
    </div>
  </div>
""")
