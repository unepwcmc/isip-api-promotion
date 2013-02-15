window.JST ||= {}

window.JST['changes_row'] = _.template("""

  <% if (change.get('change_type') === 'NEW') { %>
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
  <% } else if (change.get('change_type') === 'ANNOTATION') { %>
  <td>
    <%= speciesName %>
    <span class="author"><%= speciesAuthor %></span>
  </td>
  <td>
    <div class="new-annotation <% if (change.get('applied')) { %>done<% } %>">
      <div>
        New or updated annotations
      </div>
    </div>
  <% } else { %>
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
      <%
        var newListing = change.get('species_listing_name');
        if (change.get('change_type') === 'DELETION') {
          newListing = "deletion";
        }
      %>
      <div class="icon <%= newListing %>"></div>
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
