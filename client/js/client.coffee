#Metier
joueurs=[]

socket.on "init_joueur",(liste_joueurs) ->
	joueurs=liste_joueurs;
	console.log("Liste des joueurs init")

socket.on "nouveau_joueur",(nouveauJoueur) ->
	joueurs.push nouveauJoueur
	console.log("Nouveau Joueur ajouté")

