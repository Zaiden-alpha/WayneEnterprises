const track = document.getElementById('carouselTrack');
const dotsContainer = document.getElementById('carouselDots');
const totalSlides = 7;

let currentIndex = 0;
let autoplayTimer;



//Génère les points cliquables automatiquement

for (let i = 0; i < totalSlides; i++) {
    const dot =document.createElement('span');
    dot.classList.add('carousel-dot');
    if (i === 0) dot.classList.add('active');
    dot.addEventListener('click', () => goToSlide(i));
    dotsContainer.appendChild(dot);
}

function updateCarousel() {
    track.style.transform = `translateX(-${currentIndex * 100}%)`;
    document.querySelectorAll('.carousel-dot').forEach((dot, i) => {
        dot.classList.toggle('active', i === currentIndex);
    });
}

function goToSlide(index) {
    currentIndex = index;
    updateCarousel();
    resetAutoplay();
}

function moveCarousel(direction){
    currentIndex = (currentIndex + direction + totalSlides) % totalSlides;
    updateCarousel();
    resetAutoplay();
}


function resetAutoplay() {
    clearInterval(autoplayTimer);
    autoplayTimer = setInterval(() => moveCarousel(1), 4000); 
}

resetAutoplay(); //démarre l'autoplauy au chargement