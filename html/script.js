// Bus Routen Daten
const busRoutes = [
    {
        id: 1,
        name: 'Stadtzentrum Route',
        stops: 5,
        duration: '3 Min',
        payment: 'ca 2000€',
        difficulty: 'Einfach',
        passengers: '12-18'
    },
    {
        id: 2,
        name: 'Flughafen Express',
        stops: 5,
        duration: '20 Min',
        payment: '$650',
        difficulty: 'Mittel',
        passengers: '20-25'
    },
    {
        id: 3,
        name: 'Paleto Bay',
        stops: 12,
        duration: '30 Min',
        payment: '$850',
        difficulty: 'Schwer',
        passengers: '15-20'
    },
    
];

let selectedRouteId = null;
let isStarting = false;

// Difficulty Farbe bestimmen
function getDifficultyClass(difficulty) {
    switch (difficulty) {
        case 'Einfach':
            return 'difficulty-easy';
        case 'Mittel':
            return 'difficulty-medium';
        case 'Schwer':
            return 'difficulty-hard';
        default:
            return '';
    }
}

// Route Karte erstellen
function createRouteCard(route) {
    const card = document.createElement('div');
    card.className = 'route-card';
    card.dataset.routeId = route.id;
    card.onclick = () => selectRoute(route.id);

    card.innerHTML = `
        <div class="route-header">
            <h3 class="route-name">${route.name}</h3>
            <div class="selected-indicator" style="display: none;">
                <div class="selected-dot"></div>
            </div>
        </div>
        <div class="route-info">
            <div class="info-row">
                <span class="info-label">Zeit:</span>
                <span class="info-value">${route.duration}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Länge:</span>
                <span class="info-value">${route.stops} Stops</span>
            </div>
            <div class="info-row">
                <span class="info-label">Level:</span>
                <span class="info-value ${getDifficultyClass(route.difficulty)}">${route.difficulty}</span>
            </div>
        </div>
    `;

    return card;
}

// Routen rendern
function renderRoutes() {
    const grid = document.getElementById('routesGrid');
    grid.innerHTML = '';
    
    busRoutes.forEach(route => {
        const card = createRouteCard(route);
        grid.appendChild(card);
    });
}

// Route auswählen
function selectRoute(routeId) {
    selectedRouteId = routeId;
    
    // Alle Karten aktualisieren
    document.querySelectorAll('.route-card').forEach(card => {
        const cardRouteId = parseInt(card.dataset.routeId);
        const indicator = card.querySelector('.selected-indicator');
        
        if (cardRouteId === routeId) {
            card.classList.add('selected');
            indicator.style.display = 'flex';
        } else {
            card.classList.remove('selected');
            indicator.style.display = 'none';
        }
    });
    
    // Start Button aktualisieren
    updateStartButton();
}

// Start Button aktualisieren
function updateStartButton() {
    const startBtn = document.getElementById('startBtn');
    const infoText = document.getElementById('infoText');
    
    if (selectedRouteId === null) {
        startBtn.disabled = true;
        infoText.classList.add('visible');
    } else {
        startBtn.disabled = false;
        infoText.classList.remove('visible');
    }
}

// Route starten
function startRoute() {
    if (selectedRouteId === null || isStarting) return;
    
    isStarting = true;
    const startBtn = document.getElementById('startBtn');
    const startBtnText = document.getElementById('startBtnText');
    
    startBtnText.textContent = 'Wird gestartet...';
    startBtn.disabled = true;
    
    // Hier würde die FiveM Integration stattfinden
    // Beispiel für FiveM NUI Callback:
    
    fetch(`https://${GetParentResourceName()}/startRoute`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            routeId: selectedRouteId
        })
    });
    
    
    console.log('Starting route:', selectedRouteId);
    
    $('.menu').hide();


    // Simulation
    setTimeout(() => {
        isStarting = false;
        startBtnText.textContent = 'Route starten';
        updateStartButton();
        
        // Optional: Menü schließen nach Start
        // closeMenu();
    }, 1000);
}

// Menü schließen
function closeMenu() {

    console.log('Closing menu');
    
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(() => {
        document.querySelector('.menu').style.display = 'none';
    })
    .catch((error) => {
        console.error('Error:', error);
    });
    
}

$('#closeButton').click(function() {
    closeMenu();
});

// ESC Taste zum Schließen
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        closeMenu();
    }
});

// Initialisierung
document.addEventListener('DOMContentLoaded', () => {
    renderRoutes();
    updateStartButton();
});
window.addEventListener('message', (event) => {
    if (event.data.action === 'open') {
        document.querySelector('.menu').style.display = 'block';
    }

    if (event.data.action === 'close') {
        document.querySelector('.menu').style.display = 'none';
    }
});