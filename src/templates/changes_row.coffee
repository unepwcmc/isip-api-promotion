window.JST ||= {}

window.JST['changes_row'] = _.template("""
  <% if (change.get('change_type_name') === 'NEW_SPECIES') { %>
  <td class="empty">
    New species to be added
  </td>
  <td>
    <div class="new-species">
      <%= speciesName %>
      <span class="author"><%= speciesAuthor %></span>
    </div>
  <% } else { %>
  <td>
    <%= speciesName %>
    <span class="author"><%= speciesAuthor %></span>
  </td>
  <td>
    <div class="appendix-change">
      <div class="icon <%= speciesListing.toLowerCase() %>"></div>
      <div class="icon <%= change.get('species_listing_name')%>"></div>
    </div>
  <% } %>
    <div class="control">
      <% if (!change.get('applied')) { %>
        <a class="btn">Apply</a>
      <% } else { %>
        <a class="btn activated">Undo</a>
      <% } %>
    </div>
  </td>
""")
