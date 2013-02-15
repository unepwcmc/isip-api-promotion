window.JST ||= {}

window.JST['changes_row_new'] = _.template("""
  <% if (change.get('applied')) { %>
    <td>
      <div class="fade-in">
        <%= speciesName %>
        <span class="author"><%= speciesAuthor %></span>
      </div>
  <% } else { %>
    <td class="empty">
      New species to be added
  <% } %>
    </td>
  <td>
    <div class="new-species <% if (change.get('applied')){ %>move<% } %>">
      <div>
        <%= speciesName %>
        <span class="author"><%= speciesAuthor %></span>
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
