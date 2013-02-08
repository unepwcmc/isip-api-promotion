window.JST ||= {}

window.JST['changes_row'] = _.template("""
  <span class="change-text">
    <% if(change.get('applied') === true) { %><strike><% } %>
      <%= change.get('change_type_name')%>: <%= typeof species !== 'undefined' ? species.get('full_name') : 'Unknown species' %> to appendix
    <% if(change.get('applied') === true) { %></strike><% } %>
  </span>
  <span class="appendix <%= change.get('species_listing_name') %>"><%= change.get('species_listing_name')%></span>
  <button>Apply</button>
""")
