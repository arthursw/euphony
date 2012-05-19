$(document)
  .on 'selectstart', ->
    false
  .on 'ready', ->

    # global loader to show progress
    window.loader = new LoaderWidget()

    #start app
    window.app = new Euphony()
    app.initScene()
    app.initMidi ->
      app.getBuiltinMidiIndex (index) ->
        window.player = new PlayerWidget('#player')
        player.setPlaylist(index)
        player.on('pause', app.pause)
        player.on('resume', app.resume)
        player.on('stop', app.stop)
        player.on('play', app.play)
        player.on('setprogress', app.setProgress)
        player.on 'settrack', (filename) ->
          loader.message 'Loading MIDI', ->
            app.setBuiltinMidi filename, ->
              loader.stop ->
                player.play()
        app.on('progress', player.displayProgress)

        player.show ->
          player.setTrack(player.getRandomTrack())
