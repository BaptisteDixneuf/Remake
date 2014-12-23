#Metier
idjoueur=null;
joueurs=[]

deplacement_joueur =(id,direction)->
  if(direction is "haut") then joueurs[id].y=joueurs[id].y+1
  if(direction is "bas") then joueurs[id].y=joueurs[id].y-1
  if(direction is "droite") then joueurs[id].x=joueurs[id].x+1
  if(direction is "gauche") then joueurs[id].x=joueurs[id].x-1
  

socket.on "init_joueur",(liste_joueurs) ->
	joueurs=liste_joueurs
	idjoueur=liste_joueurs.length-1
	console.log("Réception : Liste des joueurs init")

socket.on "nouveau_joueur",(nouveauJoueur) ->
	joueurs.push nouveauJoueur
	console.log("Réception: Nouveau Joueur ajouté")

socket.on "deplacement_joueur",(data) ->
	deplacement_joueur(data.idjoueur,data.direction)
	console.log("Réception: deplacement")


controle_clavier = ->
  
  # Gestion du clavier
  blocage = 1
  window.onkeydown = (event) ->
    if blocage
      
      # On reupeee le code de la touche
      e = event or window.event
      key = e.which or e.keyCode
    switch key    
      when 38 # Fleche haut
        blocage = 0
        deplacement "haut"
        setTimeout (->
          blocage = 1
          return
        ), 620
      when 40 # Fleche bas
        blocage = 0
        deplacement "bas"
        setTimeout (->
          blocage = 1
          return
        ), 620
      when 37 # Fleche gauche
        blocage = 0
        deplacement "gauche"
        setTimeout (->
          blocage = 1
          return
        ), 620
      when 39 # Fleche droite
        blocage = 0
        deplacement "droite"
        setTimeout (->
          blocage = 1
          return
        ), 620
      else
        
        # Si la touche ne nous sert pas, nous n avons aucune raison de bloquer son comportement normal
        return true
    false

  return

controle_clavier()

deplacement = (direction) ->	
	socket.emit "deplacement",{idjoueur,direction}
	false


