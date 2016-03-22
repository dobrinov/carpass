/*!
 * Fullscreen background image jQuery plugin
 * Author: Deyan Dobrinov
 */

;(function ($, window, document, undefined){

  var pluginName = 'fullscreenBackgroundImage',
      defaults = {
        selectors: { // BEM
          container: '.fullscreen-background-image'
        }
      };

  function FullscreenBackgroundImage(element, options){
    var self = this;

    self.element = element;

    self.options = $.extend({}, defaults, options) ;

    self._defaults = defaults;
    self._name = pluginName;

    self.init();
  }

  FullscreenBackgroundImage.prototype.init = function(){
    var self = this;

    self.node  = $(self.options.selectors.container);

    self.loadImage();

    $(window).resize(function(){
      self.resize();
    });

    self.resize();
  };

  FullscreenBackgroundImage.prototype.loadImage = function(){
    var self = this;

    var image = self.node.attr('data-image');

    console.log(image);
    self.node.css('background-image', 'url(' + image + ')');
  };

  FullscreenBackgroundImage.prototype.resize = function(){
    var self = this;
    self.node.height(self.getVisibleHeight());
  };

  FullscreenBackgroundImage.prototype.getVisibleWidth = function(){
    return window.innerWidth||document.documentElement.clientWidth||document.body.clientWidth||0;
  };

  FullscreenBackgroundImage.prototype.getVisibleHeight = function(){
    return window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight||0;
  };

  $.fn[pluginName] = function(options){
    return this.each(function(){
      if (!$.data(this, 'plugin_' + pluginName)) {
        $.data(this, 'plugin_' + pluginName, new FullscreenBackgroundImage(this, options));
      }
    });
  };

})(jQuery, window, document);


$(document).ready(function(){
  $('.fullscreen-background-image').fullscreenBackgroundImage();
});