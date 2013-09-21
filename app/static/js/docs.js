(function() {
  require.config({
    paths: {
      backbone: '/js/vendor/backbone',
      underscore: '/js/vendor/underscore',
      jquery: '/js/vendor/jquery-1.10.2.min'
    },
    shim: {
      jquery: {
        exports: 'jQuery'
      },
      underscore: {
        exports: '_'
      },
      backbone: {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone'
      }
    }
  });

  define(['jquery', 'backbone'], function($, Backbone) {
    var DocNav, DocRouter, cached_pages, doc_router, nav;

    doc_router = {};
    nav = {};
    cached_pages = {};
    DocRouter = Backbone.Router.extend({
      routes: {
        'docs': 'getDefault',
        'docs/:page': 'getPage'
      },
      getDefault: function() {
        return this.getPage('overview');
      },
      getPage: function(page) {
        if (cached_pages[page] != null) {
          $('#main').html(cached_pages[page]);
          return;
        }
        return $.ajax({
          url: '/docs/partial/' + page,
          success: function(html) {
            cached_pages[page] = html;
            return $('#main').html(html);
          },
          error: function() {
            return $('#main').html('Problem loading API Document.');
          }
        });
      }
    });
    DocNav = Backbone.View.extend({
      el: '#main_nav',
      events: {
        'click a': 'goToPage'
      },
      goToPage: function(e) {
        var el, href;

        e.preventDefault();
        el = $(e.currentTarget);
        href = el.attr('href');
        return doc_router.navigate(href, {
          trigger: true
        });
      }
    });
    return $(function() {
      doc_router = new DocRouter();
      nav = new DocNav();
      if (!Modernizr.history) {
        return Backbone.history.start({
          silent: true
        });
      } else {
        return Backbone.history.start({
          pushState: true,
          silent: true
        });
      }
    });
  });

}).call(this);
