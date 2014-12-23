#Serveur socket IO
handler = (req, res) ->
  fs.readFile __dirname + "/index.html", (err, data) ->
    if err
      res.writeHead 500
      return res.end("Error loading index.html")
    res.writeHead 200
    res.end data
    return

  return

uniqueId = (length=8) ->
  id = ""
  id += Math.random().toString(36).substr(2) while id.length < length
  id.substr 0, length

app = require("http").createServer(handler)
io = require("socket.io")(app)
fs = require("fs")
app.listen 80
console.log "Serveur OK"

#Metier
joueurs=[]
class Joueur
  #Constructeur
  constructor: (@id)->

io.on "connection", (socket) ->
  console.log "Nouveau utilisateur"
  id=uniqueId(20) 
  joueurs.push new Joueur(id)
  for joueur in joueurs
    console.log(joueur)
  return
