window.JST ||= {}

window.JST['changes_row_addition'] = _.template("""
  <td>
    <%= speciesName %>
    <span class="author"><%= speciesAuthor %></span>
  </td>
  <td>
    <div class="appendix-change <% if (change.get('applied')){ %>move<% } %>">
      <% if (change.get('previousListing') != undefined) { %>
        <div class="icon <%= change.get('previousListing').toLowerCase() %>"></div>
      <% } else { %>
        <div class="icon <%= speciesListing.toLowerCase() %>"></div>
      <% } %>
      <div class="icon <%= change.get('species_listing_name') %>"></div>
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
