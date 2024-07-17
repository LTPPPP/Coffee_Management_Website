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

//schedule

let dayFrom = document.querySelector('.schedule-dayFrom');
let monthFrom = document.querySelector('.schedule-monthFrom');
let dayTo = document.querySelector('.schedule-dayTo');
let monthTo = document.querySelector('.schedule-monthTo');

setInterval(() => {

    // get monday day
    let currentTime = new Date();
    var currDay = 0;
    if (currentTime.getDay() != 0) {
        currDay = currentTime.getDay();
    } else {
        //gán chủ nhật vào
        currDay = 7;
    }

    let distanceDay = currDay - 1;
    let monday = currentTime.getDate() - distanceDay;
    let monthOfModay = currentTime.getMonth() + 1;

    if (monday <= 0) {
        switch (currentTime.getMonth()) {
            case 0:
            case 4:
            case 6:
            case 7:
            case 9:
            case 11:
                monday = 30 + monday;
                break;
            //tháng 2 lùi lại là tháng 1
            case 1:
            case 3:
            case 5:
            case 8:
            case 10:
                monday = 31 + monday;
                break;
            //tháng 3 lùi lại là tháng 2
            case 2:
                if (currentTime.getFullYear() % 4 == 0 || currentTime.getFullYear() % 400 == 0) {
                    monday = 29 + monday;
                } else {
                    monday = 28 + monday;
                }
                break;
        }
        if (currentTime.getMonth() == 0) {
            monthOfModay = 11
        } else if (currentTime.getMonth() == 1) {
            monthOfModay = 12
        } else {
            monthOfModay = currentTime.getMonth() + 1;
        }
    }

    dayFrom.innerHTML = (monday < 10 ? "0" : "") + monday;
    monthFrom.innerHTML = (monthOfModay < 10 ? "0" : "") + monthOfModay;

    dayTo.innerHTML = ((monday + 6) < 10 ? "0" : "") + (monday + 6);
    monthTo.innerHTML = (monthOfModay < 10 ? "0" : "") + monthOfModay;
    //getmonth

    // issue not check yet
    // - chưa check nếu số ngày lớn hơn số ngày trong tháng của ngày kết thúc 
    // - chưa check nếu số ngày lớn hơn số ngày trong tháng của ngày bắt đầu

}, 1000)