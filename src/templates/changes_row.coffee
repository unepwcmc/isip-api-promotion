window.JST ||= {}

window.JST['changes_row'] = _.template("""
  <%= model.getSpecies().get('species_name') + ': ' + model.get('change_type_name') %>:<button>apply</button>
""")
