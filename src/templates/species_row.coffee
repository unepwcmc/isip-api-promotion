window.JST ||= {}

window.JST['species_row'] = _.template("""
  <%= model.get('full_name') %>
  <span class="state">
    <div class="appendix <%= model.get('current_listing') %>"><%= model.get('current_listing') %></div>
    <% if(pendingChangeCount > 0) { %>
      <div class="notification"><%= pendingChangeCount %></div>
    <% } %>
  </span>
""")
