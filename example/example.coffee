readFile = (name) ->
  q = new XMLHttpRequest()
  q.open 'GET', name, false
  q.send()
  return q.responseText

require.config
  baseUrl: '../js'
  paths: JSON.parse readFile '../requirejs-paths.json'

require ['droplet'], (droplet) ->

  # Example palette
  window.editor = new droplet.Editor document.getElementById('editor'), {
    # JAVASCRIPT TESTING:
    mode: 'javascript'
    palette: [
      {
        name: 'Draw'
        color: 'blue'
        blocks: [
          {block:'a + b', title: 'Add two numbers'}
        ]
      }
    ]
    ###
    mode: 'coffeescript'
    palette: [
      {
        name: 'Draw'
        color: 'blue'
        blocks: [
          {block:'pen red', title:'Set the pen color'},
          {block:'fd 100', title:'Move forward'},
          {block:'rt 90', title:'Turn right'},
          {block:'lt 90', title:'Turn left'},
          {block:'bk 100', title:'Move backward'},
          {block:'dot blue, 50', title:'Make a dot'},
          {block:'box green, 50', title:'Make a square'},
          {block:'speed 10', title:'Set the speed of the turtle'},
          {block:'label \'hello\'', title:'Write text at the turtle'},
          {block:'do ht', title:'Hide the turtle'},
          {block:'do st', title:'Show the turtle'},
          {block:'do pu', title:'Lift the pen up'},
          {block:'do pd', title:'Put the pen down'},
          {block:'pen purple, 10', title:'Set the pen color and size'},
          {block:'rt 180, 100', title:'Make a wide right turn'},
          {block:'lt 180, 100', title:'Make a wide left turn'},
          {block:'slide 100, 20', title:'Slide diagonally or sideways'},
          {block:'jump 100, 20', title:'Jump without drawing'},
          {block:'play \'GEC\'', title:'Play music notes'},
          {block:'wear \'/img/cat-icon\'', title:'Change the turtle picture'}
        ]
      },
      {
        name: 'Control',
        color: 'orange',
        blocks: [
          {
            block: '''
            button 'Click', ->
              ``
            '''
            title: 'Make a button and do something when clicked'
          },
          {
            block: '''
            for [1..3]
              ``
            '''
            title: 'Do something multiple times'
          },
          {
            block: '''
            for x in [1..3]
              ``
            '''
            title: 'Do something multiple times...?'
          },
          {
            block: '''
            while ``
              ``
            '''
            title: 'Repeat something while a condition is true'
          },
          {
            block: '''
            read 'Name?', (n) ->
              write 'Hello' + n
            '''
            title: 'Read input from the user'
          },
          {
            block: '''
            if ``
              ``
            '''
            title: 'Do something only if a condition is true'
          },
          {
            block: '''
            if ``
              ``
            else
              ``
            '''
            title: 'Do something if a condition is true, otherwise do something else'
          },
        ]
      }
      {
        name: 'Calculate'
        color: 'green'
        blocks: [
          {block:'x = ``', title:'Set a variable'},
          {block:'`` + ``', title:'Add two numbers'},
          {block:'`` - ``', title:'Subtract two numbers'},
          {block:'`` * ``', title:'Multiply two numbers'},
          {block:'`` / ``', title:'Divide two numbers'},
          {block:'`` is ``', title:'Compare two values'},
          {block:'`` < ``', title:'Compare two values'},
          {block:'`` > ``', title:'Compare two values'},
          {block:'random [1..100]', title:'Get a random number in a range'},
          {block:'round ``', title:'Round to the nearest integer'},
          {block:'abs ``', title:'Absolute value'},
          {block:'max ``, ``', title:'Get the larger of two numbers'},
          {block:'min ``, ``', title:'Get the smaller on two numbers'},
          {
            block:'''
            f = (param) ->
              ``
            '''
            title: 'Define a new function'
          },
          {
            block:'''
            myFunction(myArgument)
            '''
            title: 'Use a custom function'
          }
        ]
      }
      {
        name: 'Interact',
        color: 'violet',
        blocks: [
          {block:'speed Infinity', title:'Make the turtle move immediately'},
          {
            block:'''
            tick 1, ->
              ``
            '''
            title: 'Do something at equally-spaced times'
          }
          {block: 'moveto lastclick', title: 'Move to a location'}
          {block: 'turnto lastmousemove', title: 'Turn towards a location'}
          {
            block:'''
            click ->
              write 'Heh!'
            '''
            title: 'Do something when the turtle is clicked'
          }
          {
            block:'''
            if pressed 'enter'
              write 'Holding.'
            '''
            title: 'Test if a key is pressed'
          }
          {block:'p = new Piano', title:'Make a new piano'}
          {block:'p.play \'EDC\'', title:'Tell a piano to play notes'}
          {block:'w = new Webcam', title:'Make a new webcam'}
          {block:'t = new Turtle', title:'Make a new turtle'}
        ]
      }
    ]
    ###
  }

  # Example program (fizzbuzz)
  examplePrograms = {
    fizzbuzz: '''
    for i in [1..1000]
      if i % 15 is 0
        see 'fizzbuzz'
      else
        if i % 5 is 0
          see 'fizz'
        if i % 3 is 0
          see 'buzz'
        if i % 3 isnt 0 and i % 5 isnt 0
          see i
    '''
    quicksort: '''
    globalNumberOfComparisons = 0
    bubblesort = (list) ->
      for _ in [1..list.length]
        for item, i in list
          globalNumberOfComparisons += 1
          if list[i] > list[i+1]
            temp = list[i]
            list[i] = list[i + 1]
            list[i + 1] = temp
      return list
    quicksort = ([head,tail...]) ->
      return [] unless head?
      globalNumberOfComparisons += 1 + tail.length
      smaller_sorted = quicksort (e for e in tail when e <= head)
      larger_sorted = quicksort (e for e in tail when e > head)
      return smaller_sorted.concat([head]).concat(larger_sorted)
    array = [1..1000]
    array.sort (a, b) ->
      if Math.random() > 0.5
        return 1
      else
        return -1
      return 0
    quicksort array
    quicksortSpeed = globalNumberOfComparisons
    see 'Quicksort finished in ' + globalNumberOfComparisons + ' operations'
    array.sort (a, b) ->
      if Math.random() > 0.5
        return 1
      else
        return -1
      return 0
    globalNumberOfComparisons = 0
    bubblesort array
    see 'Bubblesort finished in ' + globalNumberOfComparisons + ' operations'
    see 'Quicksort was ' + globalNumberOfComparisons / quicksortSpeed + ' times faster'
    '''
    church: '''
    zero = (f) -> (x) -> x
    church = (n) ->
      if n > 0
        return succ church n-1
      return zero
    unchurch = (n) -> n((x) -> x + 1) 0
    succ = (n) -> (f) -> (x) -> f n(f) x
    add = (m, n) -> (f) -> (x) -> m(f) n(f) x
    mult = (m, n) -> (f) -> n m f
    exp = (m, n) -> n m
    pred = (n) -> (f) -> (x) -> n((g) -> (h) -> h(g(f)))(->x)((u)->u)
    sub = (m, n) -> n(pred) m
    see unchurch exp church(2), church(6)
    see unchurch add church(3), church(10)
    see unchurch sub church(10), church(3)
    '''
    controller: readFile '../src/controller.coffee'
    compiler: readFile '../test/data/nodes.coffee'
    empty: ''
  }

  editor.setEditorState false
  editor.aceEditor.getSession().setUseWrapMode true

  # Initialize to starting text
  startingText = localStorage.getItem 'example'
  editor.setValue startingText or examplePrograms.fizzbuzz

  # Update textarea on ICE editor change
  onChange = ->
    localStorage.setItem 'example', editor.getValue()

  editor.on 'change', onChange

  editor.aceEditor.on 'change', onChange

  # Trigger immediately
  do onChange

  document.getElementById('which_example').addEventListener 'change', ->
    editor.setValue examplePrograms[@value]

  editor.clearUndoStack()

  messageElement = document.getElementById 'message'
  displayMessage = (text) ->
    messageElement.style.display = 'inline'
    messageElement.innerText = text
    setTimeout (->
      messageElement.style.display = 'none'
    ), 2000

  document.getElementById('toggle').addEventListener 'click', ->
    editor.toggleBlocks()
    if $('#palette_dialog').dialog 'isOpen'
      $('#palette_dialog').dialog 'close'
    else
      $("#palette_dialog").dialog 'open'
