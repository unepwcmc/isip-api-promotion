window.JST ||= {}

window.JST['changes_row'] = _.template("""
  <% if (change.get('change_type_name') === 'NEW_SPECIES') { %>
  <td class="empty">
    New species to be added
  </td>
  <td>
    <div class="new-species">
      <%= speciesName %>
      <span class="author"><%= speciesAuthor %></span>
    </div>
  <% } else { %>
  <td>
    <%= speciesName %>
    <span class="author"><%= speciesAuthor %></span>
  </td>
  <td>
    <div class="appendix-change">
      <div class="icon <%= speciesListing.toLowerCase() %>"></div>
      <div class="icon <%= change.get('species_listing_name')%>"></div>
    </div>
  <% } %>
    <div class="control">
      <% if (!change.get('applied')) { %>
        <a class="btn">Apply</a>
      <% } else { %>
        <a class="btn activated">Undo</a>
      <% } %>
    </div>
  </td>
""")
        #<td>
          #Loxodonta africana
          #<span class="author">Tesmoingst, Cleton &amp; Verdez, 1997</span>
        #</td>
        #<td>
          #<div class="appendix-change">
            #<div class="icon i"></div>
            #<div class="icon ii"></div>
          #</div>
          #<div class="control">
            #<a href="#" class="btn">Apply</a>
          #</div>
        #</td>
      #</tr>
      #<tr>
        #<td class="empty">
          #New species to be added
        #</td>
        #<td>
          #<div class="new-species">
            #Loxodonta africana
            #<span class="author">Tesmoingst, Cleton &amp; Verdez, 1997</span>
          #</div>
          #<div class="control">
            #<a href="#" class="btn activated">Undo</a>
          #</div>
        #</td>
      #</tr>
      #<tr>
        #<td>
          #Loxodonta africana
          #<span class="author">Tesmoingst, Cleton &amp; Verdez, 1997</span>
        #</td>
        #<td class="empty">
          #No changes for this species
        #</td>
      #</tr>
      #<tr>
        #<td>
          #Loxodonta africana
          #<span class="author">Tesmoingst, Cleton &amp; Verdez, 1997</span>
        #</td>
        #<td>
          #<div class="appendix-change">
            #<div class="icon iii"></div>
            #<div class="icon i"></div>
          #</div>
          #<div class="control">
            #<a href="#" class="btn">Apply</a>
          #</div>
        #</td>
