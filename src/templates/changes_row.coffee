window.JST ||= {}

window.JST['changes_row'] = _.template("""
  <td>
    <%= speciesName %>
  </td>
  <td>
    <span class="appendix <%= speciesListing %>"><%= speciesListing %></span> ->
    <span class="appendix <%= change.get('species_listing_name') %>"><%= change.get('species_listing_name')%></span>
  </td>
  <td>
    <%= change.get('applied') ? 'Applied' : 'Not Yet Applied' %>
  </td>
  <td>
    <button>Apply</button>
  </td>
""")
