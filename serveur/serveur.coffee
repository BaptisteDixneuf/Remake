#Serveur socket IO
app = require("http").createServer(handler)
io = require("socket.io")(app)
fs = require("fs")
app.listen 80

console.log "Serveur OK"

handler = (req, res) ->
  fs.readFile __dirname + "/index.html", (err, data) ->
    if err
      res.writeHead 500
      return res.end("Error loading index.html")
    res.writeHead 200
    res.end data
    return

  return

#Fonction Utile
uniqueId = (length=8) ->
  id = ""
  id += Math.random().toString(36).substr(2) while id.length < length
  id.substr 0, length

#Metier
joueurs=[]
class Joueur
  #Constructeur
  constructor: (@id)->
    this.x=0
    this.y=0;

compteurJoueur=0

#Gestion des sockets
io.on "connection", (socket) ->

  #Génération du nouvelle utilisateur
  console.log "Nouveau utilisateur"
  idjoueur=compteurJoueur
  compteurJoueur++
  nouveauJoueur = new Joueur(idjoueur) 
  joueurs.push nouveauJoueur
  

  #Gestion des joueurs
  socket.emit "init_joueur",joueurs
  socket.broadcast.emit "nouveau_joueur",nouveauJoueur

  #Deplacement Joueur 
  socket.on "deplacement", (data)->
    console.log(data)    
    false

  return
