window.JST ||= {}

window.JST['changes_row_annotation'] = _.template("""
  <td title="<%= speciesName.long %>">
    <%= speciesName.short %>
    <span class="author" title="<%= speciesAuthor.long %>"><%= speciesAuthor.short %></span>
  </td>
  <td>
    <div class="new-annotation <% if (change.get('applied')) { %>done<% } %>">
      <div>
        New or updated annotations
      </div>
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
