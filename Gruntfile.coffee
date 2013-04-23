module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - " + "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" + "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" + "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %>;" + " Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %> */\n"

    coffee:
      app:
        expand: true
        cwd: "app/assets/coffee"
        src: [ "**/*.coffee" ]
        dest: "app/static/js"
        ext: ".js"

    compass:
      dist:
        options:
          config: "config.rb"

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

    ###
    concat:
      dist:
        src: [ "App/static/js/<%= pkg.name %>.js" ]
        dest: "App/static/js/<%= pkg.name %>.min.js"

    uglify:
      dist:
        src: "App/static/js/*.js"
        dest: "App/static/js/*.min.js"
    ###
    

    watch:
      gruntfile:
        files: "<%= jshint.gruntfile.src %>"
        tasks: [ "jshint:gruntfile" ]

      lib_test:
        files: "<%= jshint.lib_test.src %>"
        tasks: [ "jshint:lib_test", "qunit" ]

      coffee:
        files: [ "app/assets/coffee/**/*.coffee" ]
        tasks: [ "coffee" ]

      compass:
        files: [ "app/assets/sass/**/*.sass" ]
        tasks: [ "compass" ]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  # grunt.loadNpmTasks "grunt-contrib-concat"
  # grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-nodeunit"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-watch"

  grunt.registerTask "default", [ "coffee", "compass", "jshint" ]