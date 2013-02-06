window.JST ||= {}

window.JST['changes_row'] = _.template("""
  <% if(model.get('applied') === true) { %><strike><% } %>
    <%= model.changeText() %><button>Merge</button>
  <% if(model.get('applied') === true) { %></strike><% } %>
""")
