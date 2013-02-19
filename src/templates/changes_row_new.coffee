window.JST ||= {}

window.JST['changes_row_new'] = _.template("""
  <% if (change.get('applied')) { %>
    <td class="new-species" title="<%= speciesName.long %>">
      <div class="fade-in">
        <div class="icon <%= change.get('species_listing_name') %>"></div>
        <%= speciesName.short %>
        <span class="author" title="<%= speciesAuthor.long %>"><%= speciesAuthor.short %></span>
      </div>
  <% } else { %>
    <td class="empty">
      New species to be added
  <% } %>
    </td>
  <td title="<%= speciesName.long %>">
    <div class="new-species <% if (change.get('applied')){ %>move<% } %>">
      <div>
        <div class="icon <%= change.get('species_listing_name') %>"></div>
        <%= speciesName.short %>
        <span class="author" title="<%= speciesAuthor.long %>"><%= speciesAuthor.short %></span>
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
