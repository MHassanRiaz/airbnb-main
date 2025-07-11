import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['property', 'latitude', 'longitude']

  connect() {
    let map;
    let markers = [];
    let properties;
    if(this.targets.find('property')){
      properties = this.propertyTargets;
    }
    
    let setLatitude;
    let setLongitude;
    if(this.targets.find('latitude') && this.targets.find('longitude')){
      setLatitude = this.latitudeTarget;
      setLongitude = this.longitudeTarget;
    }
  
    async function initMap() {
      let initialPosition;
      if(properties && properties.length != 0){
        initialPosition = { 
          lat: parseFloat(properties[0].dataset.latitude), 
          lng: parseFloat(properties[0].dataset.longitude) 
        };
      }
      else{
        initialPosition = { 
          //TODO: Show current user location.
          lat: 0, 
          lng: 0 
        };
      }

      const { Map } = await google.maps.importLibrary("maps");
      const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

      map = new Map(document.getElementById("map"), {
        zoom: 4,
        center: initialPosition,
        mapId: "DEMO_MAP_ID",
      });

      if(properties && properties.length != 0){
        properties.forEach(element => {
          const location = { lat: parseFloat(element.dataset.latitude), lng: parseFloat(element.dataset.longitude) };
  
          const priceTag = document.createElement("div");
  
          priceTag.className = "price-tag";
          priceTag.textContent = element.dataset.price;
  
          const marker = new AdvancedMarkerElement({
            map: map,
            position: location,
            content: priceTag,
          });
          markers.push(marker);
        }); 
      }
      else {
        map.addListener("click", (mapsMouseEvent) => {
          if(setLatitude && setLongitude){
            setLatitude.value = mapsMouseEvent.latLng.toJSON().lat;
            setLongitude.value = mapsMouseEvent.latLng.toJSON().lng;

            const location = document.createElement("div");
            location.className = "price-tag";
            location.textContent = 'Location';

            for (let i = 0; i < markers.length; i++) {
              markers[i].setMap(null);
            }

            const marker = new AdvancedMarkerElement({
              map: map,
              position: mapsMouseEvent.latLng.toJSON(),
              content: location,
            });
            markers.push(marker);
          }
        });
      }
    }
    initMap();
  }
}
