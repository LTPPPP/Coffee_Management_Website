//time
let hour = document.querySelector('.hour');
let min = document.querySelector('.min');
let sec = document.querySelector('.sec');
//date
let day = document.querySelector('.day');
let month = document.querySelector('.month');
let year = document.querySelector('.year');
let dot = document.querySelectorAll('.dot');



setInterval(() => {
    let currentTime = new Date();
    // console.log(currentTime.getUTCMonth());
    //get time
    hour.innerHTML = (currentTime.getHours() < 10 ? "0" : "") + currentTime.getHours();
    min.innerHTML = (currentTime.getMinutes() < 10 ? "0" : "") + currentTime.getMinutes();
    sec.innerHTML = (currentTime.getSeconds() < 10 ? "0" : "") + currentTime.getSeconds();
    // et date
    day.innerHTML = (currentTime.getUTCDate() < 10 ? "0" : "") + currentTime.getUTCDate();

    month.innerHTML = (currentTime.getUTCMonth() < 10 ? "0" : "") + (currentTime.getUTCMonth() == 12 ? 1 : currentTime.getUTCMonth() + 1);
    year.innerHTML = (currentTime.getUTCFullYear() < 10 ? "0" : "") + currentTime.getUTCFullYear();

    dot.forEach(e => {
        e.style.opacity = (e.style.opacity == '1' ? '0' : '1');
    });
}, 1000)

// Close - Open menu

let navIco = document.querySelector('.nav-container i');
let menuIcon = document.querySelector('.nav-icon');
let menu = document.querySelector('.menu');

navIco.onclick = () => {
    menu.style.display = 'block';
}

menuIcon.onclick = () => {
    menu.style.display = 'none';
}

// close -open form staff

let productUpdateBtn = document.querySelector('.product-update-btn');
let productUpdateIcon = document.querySelector('.product-update-icon');
let formUpdateProduct = document.querySelector('.product-update-contain');

productUpdateBtn.onclick = () => {
    formUpdateProduct.style.display = 'flex';
};

productUpdateIcon.onclick = () => {
    formUpdateProduct.style.display = 'none';
};