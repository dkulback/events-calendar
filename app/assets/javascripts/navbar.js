const navbarBurger = document.getElementById('navbar-burger');
const navbarItems = document.getElementById('navbar-items');

navbarBurger.addEventListener('click', () => {
  navbarItems.classList.toggle('hidden');
});
