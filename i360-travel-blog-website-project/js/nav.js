function openNav() {
    document.querySelector('#mySidenav').style.width = "250px";
    document.querySelector('.all-over-bkg').classList.add('is-visible');
}

function closeNav() {
    document.querySelector('#mySidenav').style.width = "0";
    document.querySelector('.all-over-bkg').classList.remove('is-visible');
}

document.querySelector('.openbtn').addEventListener('click', openNav);
document.querySelector('.closebtn').addEventListener('click', closeNav);


// Map plugin integration
const map = L.map('map').setView([26.459, -82.1], 11);

L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

var marker = L.marker([26.433, -82.1]).addTo(map);
marker.bindPopup("<strong>Sanibel Island, FL</strong>").openPopup();