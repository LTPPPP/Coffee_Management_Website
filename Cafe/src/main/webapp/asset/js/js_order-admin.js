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
    console.log(currentTime.getUTCMonth());
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

let nav = document.querySelectorAll('.nav-icon');
let menu = document.querySelector('.menu');
let menuBefore = document.querySelector(('.menu'), ':before');


nav[0].onclick = () => {
    menu.style.display = 'block';
}

menuBefore.onclick = () => {
    menu.style.display = 'none';
}

nav[1].onclick = () => {
    menu.style.display = 'none';
}

// Close - Open  bill

let downIcon = document.querySelectorAll('.order-icon i');
let bill = document.querySelectorAll('.bill');

console.log(downIcon[0].style);

downIcon.forEach((e, i) => {
    console.log(i);
    e.onclick = () => {
        if (bill[i].style.display == 'none' || bill[i].style.display == '') {
            bill[i].style.display = 'block';
            e.style.rotate = '180deg';

        } else if (bill[i].style.display == 'block') {
            bill[i].style.display = 'none';
            e.style.rotate = '0deg';

        }
    }
})

