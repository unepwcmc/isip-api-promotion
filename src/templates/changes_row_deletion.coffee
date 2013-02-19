window.JST ||= {}

window.JST['changes_row_deletion'] = _.template("""
  <td title="<%= speciesName.long %>">
    <div class="<% if (change.get('applied')) { %> grey-out <% } %>">
      <%= speciesName.short %>
      <span class="author" title="<%= speciesAuthor.long %>"><%= speciesAuthor.short %></span>
    </div>
  </td>
  <td>
    <div class="appendix-change <% if (change.get('applied')){ %>move<% } %>">
      <% if (change.get('previousListing') != undefined) { %>
        <div class="icon <%= change.get('previousListing').toLowerCase() %>"></div>
      <% } else { %>
        <div class="icon <%= speciesListing.toLowerCase() %>"></div>
      <% } %>
      <div class="icon deletion"></div>
    </div>
    <div class="control">
      <% if (!change.get('applied')) { %>
        <a class="btn">Apply</a>
      <% } else { %>
        <a class="btn activated">Undo</a>
      <% } %>
    </div>
  </td>
""")
