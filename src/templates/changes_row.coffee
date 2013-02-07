window.JST ||= {}

window.JST['changes_row'] = _.template("""
  <span class="change-text">
    <% if(model.get('applied') === true) { %><strike><% } %>
      <%= model.get('change_type_name')%>: <%= model.getSpecies().get('full_name') %> to appendix
    <% if(model.get('applied') === true) { %></strike><% } %>
  </span>
  <span class="appendix <%= model.get('species_listing_name') %>"><%= model.get('species_listing_name')%></span>
  <button>Apply</button>
""")
