window.JST ||= {}

window.JST['stats'] = _.template("""
  <h1>Stats</h1>
  <ul class="stats">
    <li>Changes outstanding: <span class="value"><%= outstandingCount %></span></li>
    <li>Changes merged:  <span class="value"><%= appliedCount %></span></li>
    <li>Time saved:  <span class="value"><%= hoursSaved %> Hours</span></li>
  </ul>
""")
