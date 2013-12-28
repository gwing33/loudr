(function() {
  define(['backbone', 'marionette', 'loudr.config', 'routers/dashboardRouter', 'routers/projectRouter', 'routers/fanRouter', 'views/nav', 'models/auth', "models/noteModel", "views/note"], function(Backbone, Marionette, LoudrConfig, DashboardRouter, ProjectRouter, FanRouter, LoudrNav, LoudrAuth, NoteModel, NewNoteView) {
    var Loudr;
    Loudr = new Marionette.Application();
    Loudr.addRegions({
      navRegion: '#main_nav',
      mainRegion: '#main',
      noteRegion: '#new_note'
    });
    Loudr.setLocal = function(name, obj) {
      if (Modernizr.localstorage) {
        return localStorage.setItem(name, JSON.stringify(obj));
      }
    };
    Loudr.getLocal = function(name) {
      if (Modernizr.localstorage) {
        return JSON.parse(localStorage.getItem(name));
      } else {
        return false;
      }
    };
    Loudr.displayTitle = function(text) {
      return $('#page_header div').html(text);
    };
    Loudr.newNote = function(project_id, to, message) {
      if (this.note == null) {
        this.note = new NewNoteView({
          model: new NoteModel()
        });
      }
      if (this.noteRegion.currentView === this.note) {
        this.setLocal('newNote', {
          note_showing: false
        });
        return this.noteRegion.close();
      } else {
        this.setLocal('newNote', {
          note_showing: true
        });
        return this.noteRegion.show(this.note);
      }
    };
    Loudr.addInitializer(function() {
      LoudrConfig.auth = new LoudrAuth();
      return LoudrConfig.nav = new LoudrNav.Layout({
        collection: new LoudrNav.Collection()
      });
    });
    Loudr.on('initialize:after', function() {
      var new_note;
      LoudrConfig.routers.dash = new DashboardRouter();
      LoudrConfig.routers.project = new ProjectRouter();
      LoudrConfig.routers.fan = new FanRouter();
      this.navRegion.show(LoudrConfig.nav);
      LoudrConfig.nav.collection.show_logged_in_nav();
      new_note = this.getLocal('newNote');
      if (new_note && new_note.note_showing) {
        this.newNote();
      }
      return Backbone.history.start({
        pushState: true,
        root: "/app/"
      });
    });
    return Loudr;
  });

}).call(this);
