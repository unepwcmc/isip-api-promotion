window.JST ||= {}

window.JST['changes_row'] = _.template("""
  <%= model.get('species_name') %>
""")
