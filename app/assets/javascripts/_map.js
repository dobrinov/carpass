/*!
 * Map jQuery plugin
 * Author: Deyan Dobrinov
 */

;(function ($, window, document, undefined){

  var pluginName = 'map',
      defaults = {
        selectors: { // BEM
          container:        '.map',
          canvas:           '.map__canvas',
          input_zoom_level: '.map__input_zoom-level',
          input_lat:        '.map__input_lat',
          input_lng:        '.map__input_lng'
        },
        zoom_level: 2,
        lat: 0,
        lng: 0,
        draggable:        true,
        zoomable:         true,
        scroll_zoomable:  false,
        pin_animation:    false,
        show_marker_info: false
      };

  function Map(element, options){
    var self = this;

    self.element = element;

    self.options = $.extend({}, defaults, options) ;

    self._defaults = defaults;
    self._name = pluginName;

    self.init();
  }

  Map.prototype.init = function(){
    var self = this;

    self.node = $(self.options.selectors.container);
    self.map = $(self.options.selectors.canvas);

    self.infoWindow = undefined;

    self.input_zoom_level = $(self.options.selectors.input_zoom_level);
    self.input_lat = $(self.options.selectors.input_lat);
    self.input_lng = $(self.options.selectors.input_lng);
    self.marker_icon = self.map.attr('data-marker-icon');

    var initial_zoom_level = parseInt(self.map.data('zoom')) || self.options.zoom_level;
    var initial_lat = parseFloat(self.map.data('lat')) || self.options.lat;
    var initial_lng = parseFloat(self.map.data('lng')) || self.options.lng;
    var markers_url = self.map.attr('data-markers-url');

    self.draggable        = self.map.data('draggable') != undefined ?
                             self.map.data('draggable') : self.options.draggable;
    self.zoomable         = self.map.data('zoomable')  != undefined ?
                             self.map.data('zoomable') : self.options.zoomable;
    self.scroll_zoomable  = self.map.data('scroll-zoomable')  != undefined ?
                             self.map.data('scroll-zoomable') : self.options.scroll_zoomable;
    self.pin_animation    = self.map.data('pin-animation')  != undefined ?
                             self.map.data('pin-animation') : self.options.pin_animation;

    self.show_marker_info = self.map.data('show-marker-info')  != undefined ?
                             self.map.data('show-marker-info') : self.options.show_marker_info;


    console.log(initial_lng);
    console.log(initial_lat);
    var map_options = {
                        zoom: initial_zoom_level,
                        draggable: self.draggable,
                        scrollwheel: self.scroll_zoomable,
                        center: {
                          lat: initial_lat,
                          lng: initial_lng
                        },
                        panControl: false,
                        streetViewControl: false,
                        mapTypeControl: false,
                        zoomControl: self.zoomable,
                        zoomControlOptions: {
                          style: google.maps.ZoomControlStyle.SMALL,
                          position: google.maps.ControlPosition.LEFT_CENTER
                        },
                      };

    self.map = new google.maps.Map(document.getElementsByClassName(self.options.selectors.canvas.replace('.', ''))[0], map_options);

    if(markers_url){
      self.placeMarkers(markers_url);
    }

    google.maps.event.addListener(self.map, 'dragend', function(e) {
      var center = self.map.getCenter();

      self.input_lat.val(center.lat());
      self.input_lng.val(center.lng());
    });

    google.maps.event.addListener(self.map, 'zoom_changed', function(e) {
      self.input_zoom_level.val(self.map.zoom);
    });
  };

  Map.prototype.placeMarkers = function(marker_url){
    var self = this;

    $.ajax({
      url: marker_url,
      dataType: 'json'
    }).done(function(markers, textStatus, jqXHR){
      if(markers.constructor === Array){
        for(var i=0; i<markers.length; i++){
          self.placeMarker(markers[i].latitude, markers[i].longitude, markers[i].url);
        }
      } else {
        self.placeMarker(markers.latitude, markers.longitude, markers.url);
      }
    });
  };

  Map.prototype.placeMarker = function(lat, lng, url){
    var marker = new google.maps.Marker({
                        map:       this.map,
                        animation: this.pin_animation ? google.maps.Animation.DROP : null,
                        position:  new google.maps.LatLng(lat, lng),
                        icon: this.marker_icon,
                        url: url
                      });

    if(this.show_marker_info){
      this.attachClickEventToMarker(marker, url);
    }
  };

  Map.prototype.attachClickEventToMarker = function(marker){
    var self = this;

    google.maps.event.addListener(marker, 'click', function() {
      self.map.setCenter(marker.getPosition());

      $.ajax({
        url: marker.url,
        dataType: 'json'
      }).done(function(data,textStatus,jqXHR){
        var html =  '<a href="' + data.url + '" class="map__info-window">' +
                      '<img src="' + data.image.url + '" class="map__info-window__image" />' +
                      '<h3 class="map__info-window__text">' + data.name + '</h3>' +
                    '</a>';

        infoWindow = new google.maps.InfoWindow({
          content: html
        });

        // Close the open info window
        if(self.infoWindow){
          self.infoWindow.close();
        }

        self.infoWindow = infoWindow;

        infoWindow.open(self.map, marker);
      });
    });
  }

  $.fn[pluginName] = function(options){
    return this.each(function(){
      if (!$.data(this, 'plugin_' + pluginName)) {
        $.data(this, 'plugin_' + pluginName, new Map(this, options));
      }
    });
  };

})(jQuery, window, document);

$(document).ready(function(){
  $('.map').map();
});
