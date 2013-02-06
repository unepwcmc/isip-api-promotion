window.JST ||= {}

window.JST['species_row'] = _.template("""
  <%= model.get('species_name') %> <%= model.get('current_listing') %>
""")
