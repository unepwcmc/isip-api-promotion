window.JST ||= {}

window.JST['species_row'] = _.template("""
  <%= model.get('id') %>: <%= model.get('species_name') %>
""")
