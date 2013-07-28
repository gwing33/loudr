module.exports = (grunt) ->
  port = 3001

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - " + "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" + "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" + "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %>;" + " Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %> */\n"

    php:
      dist:
        options:
          keepalive: true,
          open: true,
          port: 3003
          base: 'api_docs/'

    coffee:
      app:
        expand: true
        cwd: "app/assets/coffee"
        src: [ "**/*.coffee" ]
        dest: "app/static/js"
        # ext: ".js"
        rename: (dest, src) ->
          return dest + '/' + src.replace '.coffee', '.js'

    jshint:
      options:
        curly: true
        eqeqeq: true
        immed: true
        latedef: true
        newcap: true
        noarg: true
        sub: true
        undef: true
        unused: true
        boss: true
        eqnull: true
        browser: true
        globals:
          jQuery: true

      gruntfile:
        src: "Gruntfile.js"

      lib_test:
        src: [ "lib/**/*.js", "test/**/*.js" ]
    
    simplemocha:
      options:
        globals: ['should']
        timeout: 3000
        ignoreLeaks: false
        # grep: '*-test'
        ui: 'bdd'
        reporter: 'Spec'

      all:
        src: ['app/tests/loudr-test.coffee']

    mocha:
      all:
        options:
          mocha:
            ignoreLeaks: false
            grep: 'food'
          urls: [ 'http://localhost:' + port + '/' ]
          run: true

#    
#    concat:
#      dist:
#        src: [ "App/static/js/<%= pkg.name %>.js" ]
#        dest: "App/static/js/<%= pkg.name %>.min.js"
#
#    uglify:
#      dist:
#        src: "App/static/js/*.js"
#        dest: "App/static/js/*.min.js"
    

    watch:
      coffee:
        files: "app/assets/coffee/**/*.coffee"
        tasks: [ "coffee" ]
      
      gruntfile:
        files: "<%= jshint.gruntfile.src %>"
        tasks: [ "jshint:gruntfile" ]

      lib_test:
        files: "<%= jshint.lib_test.src %>"
        tasks: [ "jshint:lib_test", "qunit" ]

      simplemocha:
        files: "app/tests/**/*-test.coffee"
        tasks: [ "simplemocha" ]

  grunt.loadNpmTasks "grunt-php"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-nodeunit"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-mocha"
  grunt.loadNpmTasks "grunt-simple-mocha"
  # grunt.loadNpmTasks "grunt-contrib-concat"
  # grunt.loadNpmTasks "grunt-contrib-uglify"
  

  grunt.registerTask "default", [ "coffee", "jshint", "simplemocha"] # , "mocha" ]