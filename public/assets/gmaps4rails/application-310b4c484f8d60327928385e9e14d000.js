(function() {
  var Gmaps;

  Gmaps = {};

  Gmaps.triggerOldOnload = function() {
    if (typeof Gmaps.oldOnload === 'function') {
      return Gmaps.oldOnload();
    }
  };

  Gmaps.loadMaps = function() {
    var key, load_function_name, searchLoadIncluded, value, _results;
    _results = [];
    for (key in Gmaps) {
      value = Gmaps[key];
      searchLoadIncluded = key.search(/load/);
      if (searchLoadIncluded === -1) {
        load_function_name = "load_" + key;
        _results.push(Gmaps[load_function_name]());
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  window.Gmaps = Gmaps;

  this.Gmaps4Rails = (function() {
    function Gmaps4Rails() {
      this.map = null;
      this.serviceObject = null;
      this.visibleInfoWindow = null;
      this.userLocation = null;
      this.geolocationSuccess = function() {
        return false;
      };
      this.geolocationFailure = function() {
        return false;
      };
      this.callback = function() {
        return false;
      };
      this.customClusterer = function() {
        return false;
      };
      this.infobox = function() {
        return false;
      };
      this.jsTemplate = false;
      this.default_map_options = {
        id: 'map',
        draggable: true,
        detect_location: false,
        center_on_user: false,
        center_latitude: 0,
        center_longitude: 0,
        zoom: 7,
        maxZoom: null,
        minZoom: null,
        auto_adjust: true,
        auto_zoom: true,
        bounds: [],
        raw: {}
      };
      this.default_markers_conf = {
        title: "",
        picture: "",
        width: 22,
        length: 32,
        draggable: false,
        do_clustering: false,
        randomize: false,
        max_random_distance: 100,
        list_container: null,
        offset: 0,
        raw: {}
      };
      this.markers = [];
      this.boundsObject = null;
      this.polygons = [];
      this.polylines = [];
      this.circles = [];
      this.markerClusterer = null;
      this.markerImages = [];
      this.polylines_conf = {
        strokeColor: "#FF0000",
        strokeOpacity: 1,
        strokeWeight: 2,
        clickable: false,
        zIndex: null
      };
    }

    Gmaps4Rails.prototype.initialize = function() {
      this.serviceObject = this.createMap();
      this.map = this.serviceObject;
      if (this.map_options.detect_location === true || this.map_options.center_on_user === true) {
        this.findUserLocation(this);
      }
      return this.resetSidebarContent();
    };

    Gmaps4Rails.prototype.findUserLocation = function(map_object) {
      var positionFailure, positionSuccessful;
      if (navigator.geolocation) {
        positionSuccessful = function(position) {
          map_object.userLocation = map_object.createLatLng(position.coords.latitude, position.coords.longitude);
          if (map_object.map_options.center_on_user === true) {
            map_object.centerMapOnUser();
          }
          return map_object.geolocationSuccess();
        };
        positionFailure = function() {
          return map_object.geolocationFailure(true);
        };
        return navigator.geolocation.getCurrentPosition(positionSuccessful, positionFailure);
      } else {
        return map_object.geolocationFailure(false);
      }
    };

    Gmaps4Rails.prototype.create_direction = function() {
      var directionsDisplay, directionsService, request;
      directionsDisplay = new google.maps.DirectionsRenderer();
      directionsService = new google.maps.DirectionsService();
      directionsDisplay.setMap(this.serviceObject);
      if (this.direction_conf.display_panel) {
        directionsDisplay.setPanel(document.getElementById(this.direction_conf.panel_id));
      }
      directionsDisplay.setOptions({
        suppressMarkers: false,
        suppressInfoWindows: false,
        suppressPolylines: false
      });
      request = {
        origin: this.direction_conf.origin,
        destination: this.direction_conf.destination,
        waypoints: this.direction_conf.waypoints,
        optimizeWaypoints: this.direction_conf.optimizeWaypoints,
        unitSystem: google.maps.DirectionsUnitSystem[this.direction_conf.unitSystem],
        avoidHighways: this.direction_conf.avoidHighways,
        avoidTolls: this.direction_conf.avoidTolls,
        region: this.direction_conf.region,
        travelMode: google.maps.DirectionsTravelMode[this.direction_conf.travelMode],
        language: "en"
      };
      return directionsService.route(request, function(response, status) {
        if (status === google.maps.DirectionsStatus.OK) {
          return directionsDisplay.setDirections(response);
        }
      });
    };

    Gmaps4Rails.prototype.create_circles = function() {
      var circle, _i, _len, _ref, _results;
      _ref = this.circles;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        circle = _ref[_i];
        _results.push(this.create_circle(circle));
      }
      return _results;
    };

    Gmaps4Rails.prototype.create_circle = function(circle) {
      var newCircle;
      if (circle === this.circles[0]) {
        if (circle.strokeColor != null) {
          this.circles_conf.strokeColor = circle.strokeColor;
        }
        if (circle.strokeOpacity != null) {
          this.circles_conf.strokeOpacity = circle.strokeOpacity;
        }
        if (circle.strokeWeight != null) {
          this.circles_conf.strokeWeight = circle.strokeWeight;
        }
        if (circle.fillColor != null) {
          this.circles_conf.fillColor = circle.fillColor;
        }
        if (circle.fillOpacity != null) {
          this.circles_conf.fillOpacity = circle.fillOpacity;
        }
      }
      if ((circle.lat != null) && (circle.lng != null)) {
        newCircle = new google.maps.Circle({
          center: this.createLatLng(circle.lat, circle.lng),
          strokeColor: circle.strokeColor || this.circles_conf.strokeColor,
          strokeOpacity: circle.strokeOpacity || this.circles_conf.strokeOpacity,
          strokeWeight: circle.strokeWeight || this.circles_conf.strokeWeight,
          fillOpacity: circle.fillOpacity || this.circles_conf.fillOpacity,
          fillColor: circle.fillColor || this.circles_conf.fillColor,
          clickable: circle.clickable || this.circles_conf.clickable,
          zIndex: circle.zIndex || this.circles_conf.zIndex,
          radius: circle.radius
        });
        circle.serviceObject = newCircle;
        return newCircle.setMap(this.serviceObject);
      }
    };

    Gmaps4Rails.prototype.clear_circles = function() {
      var circle, _i, _len, _ref, _results;
      _ref = this.circles;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        circle = _ref[_i];
        _results.push(this.clear_circle(circle));
      }
      return _results;
    };

    Gmaps4Rails.prototype.clear_circle = function(circle) {
      return circle.serviceObject.setMap(null);
    };

    Gmaps4Rails.prototype.hide_circles = function() {
      var circle, _i, _len, _ref, _results;
      _ref = this.circles;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        circle = _ref[_i];
        _results.push(this.hide_circle(circle));
      }
      return _results;
    };

    Gmaps4Rails.prototype.hide_circle = function(circle) {
      return circle.serviceObject.setMap(null);
    };

    Gmaps4Rails.prototype.show_circles = function() {
      var circle, _i, _len, _ref, _results;
      _ref = this.circles;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        circle = _ref[_i];
        _results.push(this.show_circle(this.circle));
      }
      return _results;
    };

    Gmaps4Rails.prototype.show_circle = function(circle) {
      return circle.serviceObject.setMap(this.serviceObject);
    };

    Gmaps4Rails.prototype.create_polygons = function() {
      var polygon, _i, _len, _ref, _results;
      _ref = this.polygons;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        polygon = _ref[_i];
        _results.push(this.create_polygon(polygon));
      }
      return _results;
    };

    Gmaps4Rails.prototype.create_polygon = function(polygon) {
      var clickable, fillColor, fillOpacity, latlng, new_poly, point, polygon_coordinates, strokeColor, strokeOpacity, strokeWeight, _i, _len;
      polygon_coordinates = [];
      for (_i = 0, _len = polygon.length; _i < _len; _i++) {
        point = polygon[_i];
        latlng = this.createLatLng(point.lat, point.lng);
        polygon_coordinates.push(latlng);
        if (point === polygon[0]) {
          strokeColor = point.strokeColor || this.polygons_conf.strokeColor;
          strokeOpacity = point.strokeOpacity || this.polygons_conf.strokeOpacity;
          strokeWeight = point.strokeWeight || this.polygons_conf.strokeWeight;
          fillColor = point.fillColor || this.polygons_conf.fillColor;
          fillOpacity = point.fillOpacity || this.polygons_conf.fillOpacity;
          clickable = point.clickable || this.polygons_conf.clickable;
        }
      }
      new_poly = new google.maps.Polygon({
        paths: polygon_coordinates,
        strokeColor: strokeColor,
        strokeOpacity: strokeOpacity,
        strokeWeight: strokeWeight,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        clickable: clickable,
        map: this.serviceObject
      });
      return polygon.serviceObject = new_poly;
    };

    Gmaps4Rails.prototype.create_markers = function() {
      this.createServiceMarkersFromMarkers();
      return this.clusterize();
    };

    Gmaps4Rails.prototype.createServiceMarkersFromMarkers = function() {
      var Lat, LatLng, Lng, index, marker, _i, _len, _ref;
      _ref = this.markers;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        marker = _ref[index];
        if (this.markers[index].serviceObject == null) {
          Lat = this.markers[index].lat;
          Lng = this.markers[index].lng;
          if (this.markers_conf.randomize) {
            LatLng = this.randomize(Lat, Lng);
            Lat = LatLng[0];
            Lng = LatLng[1];
          }
          this.markers[index].serviceObject = this.createMarker({
            "marker_picture": this.markers[index].picture ? this.markers[index].picture : this.markers_conf.picture,
            "marker_width": this.markers[index].width ? this.markers[index].width : this.markers_conf.width,
            "marker_height": this.markers[index].height ? this.markers[index].height : this.markers_conf.length,
            "marker_title": this.markers[index].title ? this.markers[index].title : null,
            "marker_anchor": this.markers[index].marker_anchor ? this.markers[index].marker_anchor : null,
            "shadow_anchor": this.markers[index].shadow_anchor ? this.markers[index].shadow_anchor : null,
            "shadow_picture": this.markers[index].shadow_picture ? this.markers[index].shadow_picture : null,
            "shadow_width": this.markers[index].shadow_width ? this.markers[index].shadow_width : null,
            "shadow_height": this.markers[index].shadow_height ? this.markers[index].shadow_height : null,
            "marker_draggable": this.markers[index].draggable ? this.markers[index].draggable : this.markers_conf.draggable,
            "rich_marker": this.markers[index].rich_marker ? this.markers[index].rich_marker : null,
            "zindex": this.markers[index].zindex ? this.markers[index].zindex : null,
            "Lat": Lat,
            "Lng": Lng,
            "index": index
          });
          this.createInfoWindow(this.markers[index]);
          this.createSidebar(this.markers[index]);
        }
      }
      return this.markers_conf.offset = this.markers.length;
    };

    Gmaps4Rails.prototype.createImageAnchorPosition = function(anchorLocation) {
      if (anchorLocation === null) {
        return null;
      } else {
        return this.createPoint(anchorLocation[0], anchorLocation[1]);
      }
    };

    Gmaps4Rails.prototype.replaceMarkers = function(new_markers, adjustBounds) {
      if (adjustBounds == null) {
        adjustBounds = true;
      }
      this.clearMarkers();
      this.markers = new Array;
      if (adjustBounds) {
        this.boundsObject = this.createLatLngBounds();
      }
      this.resetSidebarContent();
      this.markers_conf.offset = 0;
      return this.addMarkers(new_markers, adjustBounds);
    };

    Gmaps4Rails.prototype.addMarkers = function(new_markers, adjustBounds) {
      if (adjustBounds == null) {
        adjustBounds = true;
      }
      this.markers = this.markers.concat(new_markers);
      this.create_markers();
      if (adjustBounds) {
        return this.adjustMapToBounds();
      }
    };

    Gmaps4Rails.prototype.createSidebar = function(marker_container) {
      var aSel, currentMap, html, li, ul;
      if (this.markers_conf.list_container) {
        ul = document.getElementById(this.markers_conf.list_container);
        li = document.createElement('li');
        aSel = document.createElement('a');
        aSel.href = 'javascript:void(0);';
        html = marker_container.sidebar != null ? marker_container.sidebar : "Marker";
        aSel.innerHTML = html;
        currentMap = this;
        aSel.onclick = this.sidebar_element_handler(currentMap, marker_container.serviceObject, 'click');
        li.appendChild(aSel);
        return ul.appendChild(li);
      }
    };

    Gmaps4Rails.prototype.sidebar_element_handler = function(currentMap, marker, eventType) {
      return function() {
        currentMap.map.panTo(marker.position);
        return google.maps.event.trigger(marker, eventType);
      };
    };

    Gmaps4Rails.prototype.resetSidebarContent = function() {
      var ul;
      if (this.markers_conf.list_container !== null) {
        ul = document.getElementById(this.markers_conf.list_container);
        return ul.innerHTML = "";
      }
    };

    Gmaps4Rails.prototype.adjustMapToBounds = function() {
      if (this.map_options.auto_adjust || this.map_options.bounds !== null) {
        this.boundsObject = this.createLatLngBounds();
        if (this.map_options.auto_adjust) {
          this.extendBoundsWithMarkers();
          this.updateBoundsWithPolylines();
          this.updateBoundsWithPolygons();
          this.updateBoundsWithCircles();
        }
        this.extendMapBounds();
        return this.adaptMapToBounds();
      }
    };

    Gmaps4Rails.prototype.replacePolylines = function(new_polylines) {
      this.destroy_polylines();
      this.polylines = new_polylines;
      this.create_polylines();
      return this.adjustMapToBounds();
    };

    Gmaps4Rails.prototype.destroy_polylines = function() {
      var polyline, _i, _len, _ref;
      _ref = this.polylines;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        polyline = _ref[_i];
        polyline.serviceObject.setMap(null);
      }
      return this.polylines = [];
    };

    Gmaps4Rails.prototype.create_polylines = function() {
      var polyline, _i, _len, _ref, _results;
      _ref = this.polylines;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        polyline = _ref[_i];
        _results.push(this.create_polyline(polyline));
      }
      return _results;
    };

    Gmaps4Rails.prototype.exists = function(var_name) {
      return var_name !== "" && typeof var_name !== "undefined";
    };

    Gmaps4Rails.prototype.randomize = function(Lat0, Lng0) {
      var Lat, Lng, dx, dy;
      dx = this.markers_conf.max_random_distance * this.random();
      dy = this.markers_conf.max_random_distance * this.random();
      Lat = parseFloat(Lat0) + (180 / Math.PI) * (dy / 6378137);
      Lng = parseFloat(Lng0) + (90 / Math.PI) * (dx / 6378137) / Math.cos(Lat0);
      return [Lat, Lng];
    };

    Gmaps4Rails.prototype.mergeObjectWithDefault = function(object1, object2) {
      var copy_object1, key, value;
      copy_object1 = {};
      for (key in object1) {
        value = object1[key];
        copy_object1[key] = value;
      }
      for (key in object2) {
        value = object2[key];
        if (copy_object1[key] == null) {
          copy_object1[key] = value;
        }
      }
      return copy_object1;
    };

    Gmaps4Rails.prototype.mergeWithDefault = function(objectName) {
      var default_object, object;
      default_object = this["default_" + objectName];
      object = this[objectName];
      this[objectName] = this.mergeObjectWithDefault(object, default_object);
      return true;
    };

    Gmaps4Rails.prototype.random = function() {
      return Math.random() * 2 - 1;
    };

    return Gmaps4Rails;

  })();

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Gmaps4RailsBing = (function(_super) {
    __extends(Gmaps4RailsBing, _super);

    function Gmaps4RailsBing() {
      Gmaps4RailsBing.__super__.constructor.apply(this, arguments);
      this.map_options = {
        type: "road"
      };
      this.markers_conf = {
        infobox: "description"
      };
      this.mergeWithDefault("map_options");
      this.mergeWithDefault("markers_conf");
    }

    Gmaps4RailsBing.prototype.getMapType = function() {
      switch (this.map_options.type) {
        case "road":
          return Microsoft.Maps.MapTypeId.road;
        case "aerial":
          return Microsoft.Maps.MapTypeId.aerial;
        case "auto":
          return Microsoft.Maps.MapTypeId.auto;
        case "birdseye":
          return Microsoft.Maps.MapTypeId.birdseye;
        case "collinsBart":
          return Microsoft.Maps.MapTypeId.collinsBart;
        case "mercator":
          return Microsoft.Maps.MapTypeId.mercator;
        case "ordnanceSurvey":
          return Microsoft.Maps.MapTypeId.ordnanceSurvey;
        default:
          return Microsoft.Maps.MapTypeId.auto;
      }
    };

    Gmaps4RailsBing.prototype.createPoint = function(lat, lng) {
      return new Microsoft.Maps.Point(lat, lng);
    };

    Gmaps4RailsBing.prototype.createLatLng = function(lat, lng) {
      return new Microsoft.Maps.Location(lat, lng);
    };

    Gmaps4RailsBing.prototype.createLatLngBounds = function() {};

    Gmaps4RailsBing.prototype.createMap = function() {
      return new Microsoft.Maps.Map(document.getElementById(this.map_options.id), {
        credentials: this.map_options.provider_key,
        mapTypeId: this.getMapType(),
        center: this.createLatLng(this.map_options.center_latitude, this.map_options.center_longitude),
        zoom: this.map_options.zoom
      });
    };

    Gmaps4RailsBing.prototype.createSize = function(width, height) {
      return new google.maps.Size(width, height);
    };

    Gmaps4RailsBing.prototype.createMarker = function(args) {
      var marker, markerLatLng;
      markerLatLng = this.createLatLng(args.Lat, args.Lng);
      marker;
      if (args.marker_picture === "") {
        marker = new Microsoft.Maps.Pushpin(this.createLatLng(args.Lat, args.Lng), {
          draggable: args.marker_draggable,
          anchor: this.createImageAnchorPosition(args.Lat, args.Lng),
          text: args.marker_title
        });
      } else {
        marker = new Microsoft.Maps.Pushpin(this.createLatLng(args.Lat, args.Lng), {
          draggable: args.marker_draggable,
          anchor: this.createImageAnchorPosition(args.Lat, args.Lng),
          icon: args.marker_picture,
          height: args.marker_height,
          text: args.marker_title,
          width: args.marker_width
        });
      }
      this.addToMap(marker);
      return marker;
    };

    Gmaps4RailsBing.prototype.clearMarkers = function() {
      var marker, _i, _len, _ref, _results;
      _ref = this.markers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        _results.push(this.clearMarker(marker));
      }
      return _results;
    };

    Gmaps4RailsBing.prototype.clearMarker = function(marker) {
      return this.removeFromMap(marker.serviceObject);
    };

    Gmaps4RailsBing.prototype.showMarkers = function() {
      var marker, _i, _len, _ref, _results;
      _ref = this.markers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        _results.push(this.showMarker(marker));
      }
      return _results;
    };

    Gmaps4RailsBing.prototype.showMarker = function(marker) {
      return marker.serviceObject.setOptions({
        visible: true
      });
    };

    Gmaps4RailsBing.prototype.hideMarkers = function() {
      var marker, _i, _len, _ref, _results;
      _ref = this.markers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        _results.push(this.hideMarker(marker));
      }
      return _results;
    };

    Gmaps4RailsBing.prototype.hideMarker = function(marker) {
      return marker.serviceObject.setOptions({
        visible: false
      });
    };

    Gmaps4RailsBing.prototype.extendBoundsWithMarkers = function() {
      var locationsArray, marker, _i, _len, _ref;
      locationsArray = [];
      _ref = this.markers;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        locationsArray.push(marker.serviceObject.getLocation());
      }
      return this.boundsObject = Microsoft.Maps.LocationRect.fromLocations(locationsArray);
    };

    Gmaps4RailsBing.prototype.createClusterer = function(markers_array) {};

    Gmaps4RailsBing.prototype.clearClusterer = function() {};

    Gmaps4RailsBing.prototype.clusterize = function() {};

    Gmaps4RailsBing.prototype.createInfoWindow = function(marker_container) {
      var currentMap;
      if (marker_container.description != null) {
        if (this.markers_conf.infobox === "description") {
          marker_container.info_window = new Microsoft.Maps.Infobox(marker_container.serviceObject.getLocation(), {
            description: marker_container.description,
            visible: false,
            showCloseButton: true
          });
        } else {
          marker_container.info_window = new Microsoft.Maps.Infobox(marker_container.serviceObject.getLocation(), {
            htmlContent: marker_container.description,
            visible: false
          });
        }
        currentMap = this;
        Microsoft.Maps.Events.addHandler(marker_container.serviceObject, 'click', this.openInfoWindow(currentMap, marker_container.info_window));
        return this.addToMap(marker_container.info_window);
      }
    };

    Gmaps4RailsBing.prototype.openInfoWindow = function(currentMap, infoWindow) {
      return function() {
        if (currentMap.visibleInfoWindow) {
          currentMap.visibleInfoWindow.setOptions({
            visible: false
          });
        }
        infoWindow.setOptions({
          visible: true
        });
        return currentMap.visibleInfoWindow = infoWindow;
      };
    };

    Gmaps4RailsBing.prototype.fitBounds = function() {
      return this.serviceObject.setView({
        bounds: this.boundsObject
      });
    };

    Gmaps4RailsBing.prototype.addToMap = function(object) {
      return this.serviceObject.entities.push(object);
    };

    Gmaps4RailsBing.prototype.removeFromMap = function(object) {
      return this.serviceObject.entities.remove(object);
    };

    Gmaps4RailsBing.prototype.centerMapOnUser = function() {
      return this.serviceObject.setView({
        center: this.userLocation
      });
    };

    Gmaps4RailsBing.prototype.updateBoundsWithPolylines = function() {};

    Gmaps4RailsBing.prototype.updateBoundsWithPolygons = function() {};

    Gmaps4RailsBing.prototype.updateBoundsWithCircles = function() {};

    Gmaps4RailsBing.prototype.extendMapBounds = function() {};

    Gmaps4RailsBing.prototype.adaptMapToBounds = function() {
      return this.fitBounds();
    };

    return Gmaps4RailsBing;

  })(Gmaps4Rails);

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Gmaps4RailsGoogle = (function(_super) {
    __extends(Gmaps4RailsGoogle, _super);

    function Gmaps4RailsGoogle() {
      Gmaps4RailsGoogle.__super__.constructor.apply(this, arguments);
      this.map_options = {
        disableDefaultUI: false,
        disableDoubleClickZoom: false,
        type: "ROADMAP"
      };
      this.markers_conf = {
        clusterer_gridSize: 50,
        clusterer_maxZoom: 5,
        custom_cluster_pictures: null,
        custom_infowindow_class: null
      };
      this.mergeWithDefault("map_options");
      this.mergeWithDefault("markers_conf");
      this.kml_options = {
        clickable: true,
        preserveViewport: false,
        suppressInfoWindows: false
      };
      this.polygons_conf = {
        strokeColor: "#FFAA00",
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: "#000000",
        fillOpacity: 0.35,
        clickable: false
      };
      this.circles_conf = {
        fillColor: "#00AAFF",
        fillOpacity: 0.35,
        strokeColor: "#FFAA00",
        strokeOpacity: 0.8,
        strokeWeight: 2,
        clickable: false,
        zIndex: null
      };
      this.direction_conf = {
        panel_id: null,
        display_panel: false,
        origin: null,
        destination: null,
        waypoints: [],
        optimizeWaypoints: false,
        unitSystem: "METRIC",
        avoidHighways: false,
        avoidTolls: false,
        region: null,
        travelMode: "DRIVING"
      };
    }

    Gmaps4RailsGoogle.prototype.createPoint = function(lat, lng) {
      return new google.maps.Point(lat, lng);
    };

    Gmaps4RailsGoogle.prototype.createLatLng = function(lat, lng) {
      return new google.maps.LatLng(lat, lng);
    };

    Gmaps4RailsGoogle.prototype.createLatLngBounds = function() {
      return new google.maps.LatLngBounds();
    };

    Gmaps4RailsGoogle.prototype.createMap = function() {
      var defaultOptions, mergedOptions;
      defaultOptions = {
        maxZoom: this.map_options.maxZoom,
        minZoom: this.map_options.minZoom,
        zoom: this.map_options.zoom,
        center: this.createLatLng(this.map_options.center_latitude, this.map_options.center_longitude),
        mapTypeId: google.maps.MapTypeId[this.map_options.type],
        mapTypeControl: this.map_options.mapTypeControl,
        disableDefaultUI: this.map_options.disableDefaultUI,
        disableDoubleClickZoom: this.map_options.disableDoubleClickZoom,
        draggable: this.map_options.draggable
      };
      mergedOptions = this.mergeObjectWithDefault(this.map_options.raw, defaultOptions);
      return new google.maps.Map(document.getElementById(this.map_options.id), mergedOptions);
    };

    Gmaps4RailsGoogle.prototype.createMarkerImage = function(markerPicture, markerSize, origin, anchor, scaledSize) {
      return new google.maps.MarkerImage(markerPicture, markerSize, origin, anchor, scaledSize);
    };

    Gmaps4RailsGoogle.prototype.createSize = function(width, height) {
      return new google.maps.Size(width, height);
    };

    Gmaps4RailsGoogle.prototype.createMarker = function(args) {
      var defaultOptions, imageAnchorPosition, markerImage, markerLatLng, mergedOptions, shadowAnchorPosition, shadowImage;
      markerLatLng = this.createLatLng(args.Lat, args.Lng);
      if (args.marker_picture === "" && args.rich_marker === null) {
        defaultOptions = {
          position: markerLatLng,
          map: this.serviceObject,
          title: args.marker_title,
          draggable: args.marker_draggable,
          zIndex: args.zindex
        };
        mergedOptions = this.mergeObjectWithDefault(this.markers_conf.raw, defaultOptions);
        return new google.maps.Marker(mergedOptions);
      }
      if (args.rich_marker !== null) {
        return new RichMarker({
          position: markerLatLng,
          map: this.serviceObject,
          draggable: args.marker_draggable,
          content: args.rich_marker,
          flat: args.marker_anchor === null ? false : args.marker_anchor[1],
          anchor: args.marker_anchor === null ? 0 : args.marker_anchor[0],
          zIndex: args.zindex
        });
      }
      imageAnchorPosition = this.createImageAnchorPosition(args.marker_anchor);
      shadowAnchorPosition = this.createImageAnchorPosition(args.shadow_anchor);
      markerImage = this.createOrRetrieveImage(args.marker_picture, args.marker_width, args.marker_height, imageAnchorPosition);
      shadowImage = this.createOrRetrieveImage(args.shadow_picture, args.shadow_width, args.shadow_height, shadowAnchorPosition);
      defaultOptions = {
        position: markerLatLng,
        map: this.serviceObject,
        icon: markerImage,
        title: args.marker_title,
        draggable: args.marker_draggable,
        shadow: shadowImage,
        zIndex: args.zindex
      };
      mergedOptions = this.mergeObjectWithDefault(this.markers_conf.raw, defaultOptions);
      return new google.maps.Marker(mergedOptions);
    };

    Gmaps4RailsGoogle.prototype.includeMarkerImage = function(arr, obj) {
      var index, object, _i, _len;
      for (index = _i = 0, _len = arr.length; _i < _len; index = ++_i) {
        object = arr[index];
        if (object.url === obj) {
          return index;
        }
      }
      return false;
    };

    Gmaps4RailsGoogle.prototype.createOrRetrieveImage = function(currentMarkerPicture, markerWidth, markerHeight, imageAnchorPosition) {
      var markerImage, test_image_index;
      if (currentMarkerPicture === "" || currentMarkerPicture === null) {
        return null;
      }
      test_image_index = this.includeMarkerImage(this.markerImages, currentMarkerPicture);
      switch (test_image_index) {
        case false:
          markerImage = this.createMarkerImage(currentMarkerPicture, this.createSize(markerWidth, markerHeight), null, imageAnchorPosition, null);
          this.markerImages.push(markerImage);
          return markerImage;
          break;
        default:
          if (typeof test_image_index === 'number') {
            return this.markerImages[test_image_index];
          }
          return false;
      }
    };

    Gmaps4RailsGoogle.prototype.clearMarkers = function() {
      var marker, _i, _len, _ref, _results;
      _ref = this.markers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        _results.push(this.clearMarker(marker));
      }
      return _results;
    };

    Gmaps4RailsGoogle.prototype.showMarkers = function() {
      var marker, _i, _len, _ref, _results;
      _ref = this.markers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        _results.push(this.showMarker(marker));
      }
      return _results;
    };

    Gmaps4RailsGoogle.prototype.hideMarkers = function() {
      var marker, _i, _len, _ref, _results;
      _ref = this.markers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        _results.push(this.hideMarker(marker));
      }
      return _results;
    };

    Gmaps4RailsGoogle.prototype.clearMarker = function(marker) {
      return marker.serviceObject.setMap(null);
    };

    Gmaps4RailsGoogle.prototype.showMarker = function(marker) {
      return marker.serviceObject.setVisible(true);
    };

    Gmaps4RailsGoogle.prototype.hideMarker = function(marker) {
      return marker.serviceObject.setVisible(false);
    };

    Gmaps4RailsGoogle.prototype.extendBoundsWithMarkers = function() {
      var marker, _i, _len, _ref, _results;
      _ref = this.markers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        _results.push(this.boundsObject.extend(marker.serviceObject.position));
      }
      return _results;
    };

    Gmaps4RailsGoogle.prototype.createClusterer = function(markers_array) {
      return new MarkerClusterer(this.serviceObject, markers_array, {
        maxZoom: this.markers_conf.clusterer_maxZoom,
        gridSize: this.markers_conf.clusterer_gridSize,
        styles: this.customClusterer()
      });
    };

    Gmaps4RailsGoogle.prototype.clearClusterer = function() {
      return this.markerClusterer.clearMarkers();
    };

    Gmaps4RailsGoogle.prototype.clusterize = function() {
      var marker, markers_array, _i, _len, _ref;
      if (this.markers_conf.do_clustering === true) {
        if (this.markerClusterer !== null) {
          this.clearClusterer();
        }
        markers_array = new Array;
        _ref = this.markers;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          marker = _ref[_i];
          markers_array.push(marker.serviceObject);
        }
        return this.markerClusterer = this.createClusterer(markers_array);
      }
    };

    Gmaps4RailsGoogle.prototype.createInfoWindow = function(marker_container) {
      var boxText, currentMap;
      if (typeof this.jsTemplate === "function" || (marker_container.description != null)) {
        if (typeof this.jsTemplate === "function") {
          marker_container.description = this.jsTemplate(marker_container);
        }
        if (this.markers_conf.custom_infowindow_class !== null) {
          boxText = document.createElement("div");
          boxText.setAttribute("class", this.markers_conf.custom_infowindow_class);
          boxText.innerHTML = marker_container.description;
          marker_container.infowindow = new InfoBox(this.infobox(boxText));
          currentMap = this;
          return google.maps.event.addListener(marker_container.serviceObject, 'click', this.openInfoWindow(currentMap, marker_container.infowindow, marker_container.serviceObject));
        } else {
          marker_container.infowindow = new google.maps.InfoWindow({
            content: marker_container.description
          });
          currentMap = this;
          return google.maps.event.addListener(marker_container.serviceObject, 'click', this.openInfoWindow(currentMap, marker_container.infowindow, marker_container.serviceObject));
        }
      }
    };

    Gmaps4RailsGoogle.prototype.openInfoWindow = function(currentMap, infoWindow, marker) {
      return function() {
        if (currentMap.visibleInfoWindow !== null) {
          currentMap.visibleInfoWindow.close();
        }
        infoWindow.open(currentMap.serviceObject, marker);
        return currentMap.visibleInfoWindow = infoWindow;
      };
    };

    Gmaps4RailsGoogle.prototype.createKmlLayer = function(kml) {
      var kml_options;
      kml_options = kml.options || {};
      kml_options = this.mergeObjectWithDefault(kml_options, this.kml_options);
      kml = new google.maps.KmlLayer(kml.url, kml_options);
      kml.setMap(this.serviceObject);
      return kml;
    };

    Gmaps4RailsGoogle.prototype.create_polyline = function(polyline) {
      var clickable, decoded_array, element, latlng, new_poly, point, polyline_coordinates, strokeColor, strokeOpacity, strokeWeight, zIndex, _i, _j, _len, _len1;
      polyline_coordinates = [];
      for (_i = 0, _len = polyline.length; _i < _len; _i++) {
        element = polyline[_i];
        if (element.coded_array != null) {
          decoded_array = new google.maps.geometry.encoding.decodePath(element.coded_array);
          for (_j = 0, _len1 = decoded_array.length; _j < _len1; _j++) {
            point = decoded_array[_j];
            polyline_coordinates.push(point);
          }
        } else {
          if (element === polyline[0]) {
            strokeColor = element.strokeColor || this.polylines_conf.strokeColor;
            strokeOpacity = element.strokeOpacity || this.polylines_conf.strokeOpacity;
            strokeWeight = element.strokeWeight || this.polylines_conf.strokeWeight;
            clickable = element.clickable || this.polylines_conf.clickable;
            zIndex = element.zIndex || this.polylines_conf.zIndex;
          }
          if ((element.lat != null) && (element.lng != null)) {
            latlng = this.createLatLng(element.lat, element.lng);
            polyline_coordinates.push(latlng);
          }
        }
      }
      new_poly = new google.maps.Polyline({
        path: polyline_coordinates,
        strokeColor: strokeColor,
        strokeOpacity: strokeOpacity,
        strokeWeight: strokeWeight,
        clickable: clickable,
        zIndex: zIndex
      });
      polyline.serviceObject = new_poly;
      return new_poly.setMap(this.serviceObject);
    };

    Gmaps4RailsGoogle.prototype.updateBoundsWithPolylines = function() {
      var point, polyline, polyline_points, _i, _len, _ref, _results;
      _ref = this.polylines;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        polyline = _ref[_i];
        polyline_points = polyline.serviceObject.latLngs.getArray()[0].getArray();
        _results.push((function() {
          var _j, _len1, _results1;
          _results1 = [];
          for (_j = 0, _len1 = polyline_points.length; _j < _len1; _j++) {
            point = polyline_points[_j];
            _results1.push(this.boundsObject.extend(point));
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    Gmaps4RailsGoogle.prototype.create_kml = function() {
      var kml, _i, _len, _ref, _results;
      _ref = this.kml;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        kml = _ref[_i];
        _results.push(kml.serviceObject = this.createKmlLayer(kml));
      }
      return _results;
    };

    Gmaps4RailsGoogle.prototype.fitBounds = function() {
      if (!this.boundsObject.isEmpty()) {
        return this.serviceObject.fitBounds(this.boundsObject);
      }
    };

    Gmaps4RailsGoogle.prototype.centerMapOnUser = function() {
      return this.serviceObject.setCenter(this.userLocation);
    };

    Gmaps4RailsGoogle.prototype.updateBoundsWithPolygons = function() {
      var point, polygon, polygon_points, _i, _len, _ref, _results;
      _ref = this.polygons;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        polygon = _ref[_i];
        polygon_points = polygon.serviceObject.latLngs.getArray()[0].getArray();
        _results.push((function() {
          var _j, _len1, _results1;
          _results1 = [];
          for (_j = 0, _len1 = polygon_points.length; _j < _len1; _j++) {
            point = polygon_points[_j];
            _results1.push(this.boundsObject.extend(point));
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    Gmaps4RailsGoogle.prototype.updateBoundsWithCircles = function() {
      var circle, _i, _len, _ref, _results;
      _ref = this.circles;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        circle = _ref[_i];
        this.boundsObject.extend(circle.serviceObject.getBounds().getNorthEast());
        _results.push(this.boundsObject.extend(circle.serviceObject.getBounds().getSouthWest()));
      }
      return _results;
    };

    Gmaps4RailsGoogle.prototype.extendMapBounds = function() {
      var bound, _i, _len, _ref, _results;
      _ref = this.map_options.bounds;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        bound = _ref[_i];
        _results.push(this.boundsObject.extend(this.createLatLng(bound.lat, bound.lng)));
      }
      return _results;
    };

    Gmaps4RailsGoogle.prototype.adaptMapToBounds = function() {
      var map_center;
      if (!this.map_options.auto_zoom) {
        map_center = this.boundsObject.getCenter();
        this.map_options.center_latitude = map_center.lat();
        this.map_options.center_longitude = map_center.lng();
        return this.serviceObject.setCenter(map_center);
      } else {
        return this.fitBounds();
      }
    };

    return Gmaps4RailsGoogle;

  })(Gmaps4Rails);

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Gmaps4RailsMapquest = (function(_super) {
    __extends(Gmaps4RailsMapquest, _super);

    function Gmaps4RailsMapquest() {
      Gmaps4RailsMapquest.__super__.constructor.apply(this, arguments);
      this.map_options = {
        type: "map"
      };
      this.markers_conf = {};
      this.mergeWithDefault("markers_conf");
      this.mergeWithDefault("map_options");
    }

    Gmaps4RailsMapquest.prototype.createPoint = function(lat, lng) {
      return new MQA.Poi({
        lat: lat,
        lng: lng
      });
    };

    Gmaps4RailsMapquest.prototype.createLatLng = function(lat, lng) {
      return {
        lat: lat,
        lng: lng
      };
    };

    Gmaps4RailsMapquest.prototype.createLatLngBounds = function() {};

    Gmaps4RailsMapquest.prototype.createMap = function() {
      var map;
      map = new MQA.TileMap(document.getElementById(this.map_options.id), this.map_options.zoom, {
        lat: this.map_options.center_latitude,
        lng: this.map_options.center_longitude
      }, this.map_options.type);
      MQA.withModule('zoomcontrol3', (function() {
        return map.addControl(new MQA.LargeZoomControl3(), new MQA.MapCornerPlacement(MQA.MapCorner.TOP_LEFT));
      }));
      return map;
    };

    Gmaps4RailsMapquest.prototype.createMarkerImage = function(markerPicture, markerSize, origin, anchor, scaledSize) {};

    Gmaps4RailsMapquest.prototype.createMarker = function(args) {
      var icon, marker;
      marker = new MQA.Poi({
        lat: args.Lat,
        lng: args.Lng
      });
      if (args.marker_picture !== "") {
        icon = new MQA.Icon(args.marker_picture, args.marker_height, args.marker_width);
        marker.setIcon(icon);
        if (args.marker_anchor !== null) {
          marker.setBias({
            x: args.marker_anchor[0],
            y: args.marker_anchor[1]
          });
        }
      }
      if (args.shadow_picture !== "") {
        icon = new MQA.Icon(args.shadow_picture, args.shadow_height, args.shadow_width);
        marker.setShadow(icon);
        if (args.shadow_anchor !== null) {
          marker.setShadowOffset({
            x: args.shadow_anchor[0],
            y: args.shadow_anchor[1]
          });
        }
      }
      this.addToMap(marker);
      return marker;
    };

    Gmaps4RailsMapquest.prototype.clearMarkers = function() {
      var marker, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = markers.length; _i < _len; _i++) {
        marker = markers[_i];
        _results.push(this.clearMarker(marker));
      }
      return _results;
    };

    Gmaps4RailsMapquest.prototype.showMarkers = function() {
      var marker, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = markers.length; _i < _len; _i++) {
        marker = markers[_i];
        _results.push(this.showMarker(marker));
      }
      return _results;
    };

    Gmaps4RailsMapquest.prototype.hideMarkers = function() {
      var marker, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = markers.length; _i < _len; _i++) {
        marker = markers[_i];
        _results.push(this.hideMarker(marker));
      }
      return _results;
    };

    Gmaps4RailsMapquest.prototype.clearMarker = function(marker) {
      return this.removeFromMap(marker.serviceObject);
    };

    Gmaps4RailsMapquest.prototype.showMarker = function(marker) {};

    Gmaps4RailsMapquest.prototype.hideMarker = function(marker) {};

    Gmaps4RailsMapquest.prototype.extendBoundsWithMarkers = function() {
      var marker, _i, _len, _ref, _results;
      if (this.markers.length >= 2) {
        this.boundsObject = new MQA.RectLL(this.markers[0].serviceObject.latLng, this.markers[1].serviceObject.latLng);
        _ref = this.markers;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          marker = _ref[_i];
          _results.push(this.boundsObject.extend(marker.serviceObject.latLng));
        }
        return _results;
      }
    };

    Gmaps4RailsMapquest.prototype.createClusterer = function(markers_array) {};

    Gmaps4RailsMapquest.prototype.clearClusterer = function() {};

    Gmaps4RailsMapquest.prototype.clusterize = function() {};

    Gmaps4RailsMapquest.prototype.createInfoWindow = function(marker_container) {
      return marker_container.serviceObject.setInfoTitleHTML(marker_container.description);
    };

    Gmaps4RailsMapquest.prototype.fitBounds = function() {
      if (this.markers.length >= 2) {
        this.serviceObject.zoomToRect(this.boundsObject);
      }
      if (this.markers.length === 1) {
        return this.serviceObject.setCenter(this.markers[0].serviceObject.latLng);
      }
    };

    Gmaps4RailsMapquest.prototype.centerMapOnUser = function() {
      return this.serviceObject.setCenter(this.userLocation);
    };

    Gmaps4RailsMapquest.prototype.addToMap = function(object) {
      return this.serviceObject.addShape(object);
    };

    Gmaps4RailsMapquest.prototype.removeFromMap = function(object) {
      return this.serviceObject.removeShape(object);
    };

    Gmaps4RailsMapquest.prototype.updateBoundsWithPolylines = function() {};

    Gmaps4RailsMapquest.prototype.updateBoundsWithPolygons = function() {};

    Gmaps4RailsMapquest.prototype.updateBoundsWithCircles = function() {};

    Gmaps4RailsMapquest.prototype.extendMapBounds = function() {};

    Gmaps4RailsMapquest.prototype.adaptMapToBounds = function() {
      return this.fitBounds();
    };

    return Gmaps4RailsMapquest;

  })(Gmaps4Rails);

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Gmaps4RailsOpenlayers = (function(_super) {
    __extends(Gmaps4RailsOpenlayers, _super);

    function Gmaps4RailsOpenlayers() {
      Gmaps4RailsOpenlayers.__super__.constructor.apply(this, arguments);
      this.map_options = {};
      this.mergeWithDefault("map_options");
      this.markers_conf = {};
      this.mergeWithDefault("markers_conf");
      this.openMarkers = null;
      this.markersLayer = null;
      this.markersControl = null;
      this.polylinesLayer = null;
    }

    Gmaps4RailsOpenlayers.prototype.createPoint = function(lat, lng) {};

    Gmaps4RailsOpenlayers.prototype.createLatLng = function(lat, lng) {
      return new OpenLayers.LonLat(lng, lat).transform(new OpenLayers.Projection("EPSG:4326"), new OpenLayers.Projection("EPSG:900913"));
    };

    Gmaps4RailsOpenlayers.prototype.createAnchor = function(offset) {
      if (offset === null) {
        return null;
      }
      return new OpenLayers.Pixel(offset[0], offset[1]);
    };

    Gmaps4RailsOpenlayers.prototype.createSize = function(width, height) {
      return new OpenLayers.Size(width, height);
    };

    Gmaps4RailsOpenlayers.prototype.createLatLngBounds = function() {
      return new OpenLayers.Bounds();
    };

    Gmaps4RailsOpenlayers.prototype.createMap = function() {
      var map;
      map = new OpenLayers.Map(this.map_options.id);
      map.addLayer(new OpenLayers.Layer.OSM());
      map.setCenter(this.createLatLng(this.map_options.center_latitude, this.map_options.center_longitude), this.map_options.zoom);
      return map;
    };

    Gmaps4RailsOpenlayers.prototype.createMarker = function(args) {
      var marker, style_mark;
      style_mark = OpenLayers.Util.extend({}, OpenLayers.Feature.Vector.style['default']);
      style_mark.fillOpacity = 1;
      if (this.markersLayer === null) {
        this.markersLayer = new OpenLayers.Layer.Vector("Markers", null);
        this.serviceObject.addLayer(this.markersLayer);
        this.markersLayer.events.register("featureselected", this.markersLayer, this.onFeatureSelect);
        this.markersLayer.events.register("featureunselected", this.markersLayer, this.onFeatureUnselect);
        this.markersControl = new OpenLayers.Control.SelectFeature(this.markersLayer);
        this.serviceObject.addControl(this.markersControl);
        this.markersControl.activate();
      }
      if (args.marker_picture === "") {
        style_mark.graphicHeight = 30;
        style_mark.externalGraphic = "http://openlayers.org/dev/img/marker-blue.png";
      } else {
        style_mark.graphicWidth = args.marker_width;
        style_mark.graphicHeight = args.marker_height;
        style_mark.externalGraphic = args.marker_picture;
        if (args.marker_anchor !== null) {
          style_mark.graphicXOffset = args.marker_anchor[0];
          style_mark.graphicYOffset = args.marker_anchor[1];
        }
        if (args.shadow_picture !== "") {
          style_mark.backgroundGraphic = args.shadow_picture;
          style_mark.backgroundWidth = args.shadow_width;
          style_mark.backgroundHeight = args.shadow_height;
          if (args.shadow_anchor !== null) {
            style_mark.backgroundXOffset = args.shadow_anchor[0];
            style_mark.backgroundYOffset = args.shadow_anchor[1];
          }
        }
      }
      style_mark.graphicTitle = args.marker_title;
      marker = new OpenLayers.Feature.Vector(new OpenLayers.Geometry.Point(args.Lng, args.Lat), null, style_mark);
      marker.geometry.transform(new OpenLayers.Projection("EPSG:4326"), new OpenLayers.Projection("EPSG:900913"));
      this.markersLayer.addFeatures([marker]);
      return marker;
    };

    Gmaps4RailsOpenlayers.prototype.clearMarkers = function() {
      this.clearMarkersLayerIfExists();
      this.markersLayer = null;
      return this.boundsObject = new OpenLayers.Bounds();
    };

    Gmaps4RailsOpenlayers.prototype.clearMarkersLayerIfExists = function() {
      if (this.markersLayer !== null && this.serviceObject.getLayer(this.markersLayer.id) !== null) {
        return this.serviceObject.removeLayer(this.markersLayer);
      }
    };

    Gmaps4RailsOpenlayers.prototype.extendBoundsWithMarkers = function() {
      var marker, _i, _len, _ref, _results;
      console.log("here");
      _ref = this.markers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        _results.push(this.boundsObject.extend(this.createLatLng(marker.lat, marker.lng)));
      }
      return _results;
    };

    Gmaps4RailsOpenlayers.prototype.createClusterer = function(markers_array) {
      var clusters, funcs, options, strategy, style;
      options = {
        pointRadius: "${radius}",
        fillColor: "#ffcc66",
        fillOpacity: 0.8,
        strokeColor: "#cc6633",
        strokeWidth: "${width}",
        strokeOpacity: 0.8
      };
      funcs = {
        context: {
          width: function(feature) {
            var _ref;
            return (_ref = feature.cluster) != null ? _ref : {
              2: 1
            };
          },
          radius: function(feature) {
            var pix;
            pix = 2;
            if (feature.cluster) {
              pix = Math.min(feature.attributes.count, 7) + 2;
            }
            return pix;
          }
        }
      };
      style = new OpenLayers.Style(options, funcs);
      strategy = new OpenLayers.Strategy.Cluster();
      clusters = new OpenLayers.Layer.Vector("Clusters", {
        strategies: [strategy],
        styleMap: new OpenLayers.StyleMap({
          "default": style,
          "select": {
            fillColor: "#8aeeef",
            strokeColor: "#32a8a9"
          }
        })
      });
      this.clearMarkersLayerIfExists();
      this.serviceObject.addLayer(clusters);
      clusters.addFeatures(markers_array);
      return clusters;
    };

    Gmaps4RailsOpenlayers.prototype.clusterize = function() {
      var marker, markers_array, _i, _len, _ref;
      if (this.markers_conf.do_clustering === true) {
        if (this.markerClusterer !== null) {
          this.clearClusterer();
        }
        markers_array = new Array;
        _ref = this.markers;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          marker = _ref[_i];
          markers_array.push(marker.serviceObject);
        }
        return this.markerClusterer = this.createClusterer(markers_array);
      }
    };

    Gmaps4RailsOpenlayers.prototype.clearClusterer = function() {
      return this.serviceObject.removeLayer(this.markerClusterer);
    };

    Gmaps4RailsOpenlayers.prototype.createInfoWindow = function(marker_container) {
      if (marker_container.description != null) {
        return marker_container.serviceObject.infoWindow = marker_container.description;
      }
    };

    Gmaps4RailsOpenlayers.prototype.onPopupClose = function(evt) {
      return this.markersControl.unselect(this.feature);
    };

    Gmaps4RailsOpenlayers.prototype.onFeatureSelect = function(evt) {
      var feature, popup;
      feature = evt.feature;
      popup = new OpenLayers.Popup.FramedCloud("featurePopup", feature.geometry.getBounds().getCenterLonLat(), new OpenLayers.Size(300, 200), feature.infoWindow, null, true, this.onPopupClose);
      feature.popup = popup;
      popup.feature = feature;
      return this.map.addPopup(popup);
    };

    Gmaps4RailsOpenlayers.prototype.onFeatureUnselect = function(evt) {
      var feature;
      feature = evt.feature;
      if (feature.popup) {
        this.map.removePopup(feature.popup);
        feature.popup.destroy();
        return feature.popup = null;
      }
    };

    Gmaps4RailsOpenlayers.prototype.create_polyline = function(polyline) {
      var clickable, element, latlng, line_points, line_style, polyline_coordinates, strokeColor, strokeOpacity, strokeWeight, zIndex, _i, _len;
      if (this.polylinesLayer === null) {
        this.polylinesLayer = new OpenLayers.Layer.Vector("Polylines", null);
        this.serviceObject.addLayer(this.polylinesLayer);
        this.polylinesLayer.events.register("featureselected", this.polylinesLayer, this.onFeatureSelect);
        this.polylinesLayer.events.register("featureunselected", this.polylinesLayer, this.onFeatureUnselect);
        this.polylinesControl = new OpenLayers.Control.DrawFeature(this.polylinesLayer, OpenLayers.Handler.Path);
        this.serviceObject.addControl(this.polylinesControl);
      }
      polyline_coordinates = [];
      for (_i = 0, _len = polyline.length; _i < _len; _i++) {
        element = polyline[_i];
        if (element === polyline[0]) {
          strokeColor = element.strokeColor || this.polylines_conf.strokeColor;
          strokeOpacity = element.strokeOpacity || this.polylines_conf.strokeOpacity;
          strokeWeight = element.strokeWeight || this.polylines_conf.strokeWeight;
          clickable = element.clickable || this.polylines_conf.clickable;
          zIndex = element.zIndex || this.polylines_conf.zIndex;
        }
        if ((element.lat != null) && (element.lng != null)) {
          latlng = new OpenLayers.Geometry.Point(element.lng, element.lat);
          polyline_coordinates.push(latlng);
        }
      }
      line_points = new OpenLayers.Geometry.LineString(polyline_coordinates);
      line_style = {
        strokeColor: strokeColor,
        strokeOpacity: strokeOpacity,
        strokeWidth: strokeWeight
      };
      polyline = new OpenLayers.Feature.Vector(line_points, null, line_style);
      polyline.geometry.transform(new OpenLayers.Projection("EPSG:4326"), new OpenLayers.Projection("EPSG:900913"));
      this.polylinesLayer.addFeatures([polyline]);
      return polyline;
    };

    Gmaps4RailsOpenlayers.prototype.updateBoundsWithPolylines = function() {};

    Gmaps4RailsOpenlayers.prototype.updateBoundsWithPolygons = function() {};

    Gmaps4RailsOpenlayers.prototype.updateBoundsWithCircles = function() {};

    Gmaps4RailsOpenlayers.prototype.fitBounds = function() {
      return this.serviceObject.zoomToExtent(this.boundsObject, true);
    };

    Gmaps4RailsOpenlayers.prototype.centerMapOnUser = function() {
      return this.serviceObject.setCenter(this.userLocation);
    };

    Gmaps4RailsOpenlayers.prototype.extendMapBounds = function() {};

    Gmaps4RailsOpenlayers.prototype.adaptMapToBounds = function() {
      return this.fitBounds();
    };

    return Gmaps4RailsOpenlayers;

  })(Gmaps4Rails);

}).call(this);




