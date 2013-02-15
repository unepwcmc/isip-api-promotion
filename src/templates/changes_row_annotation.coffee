window.JST ||= {}

window.JST['changes_row_annotation'] = _.template("""
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
    <div class="control">
      <% if (!change.get('applied')) { %>
        <a class="btn">Apply</a>
      <% } else { %>
        <a class="btn activated">Undo</a>
      <% } %>
    </div>
  </td>
""")
