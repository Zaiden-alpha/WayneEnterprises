const navToggle = document.querySelector('.nav-toggle');
const navMenu = document.querySelector('nav > ul');


navToggle.addEventListener('click', () =>{
    navMenu.classList.toggle('open');
});

const here = window.location.pathname.endsWith('/')
    ? window.location.pathname + 'index.html'
    : window.location.pathname;

document.querySelectorAll('nav a').forEach(link => {
    if (link.pathname === here) {
        link.setAttribute('aria-current', 'page');
    }
});