// Scroll order
document.addEventListener("DOMContentLoaded", function () {
  const sections = document.querySelectorAll("section");

  sections.forEach((section) => {
    const itemContainer = section.querySelector(".item-container");
    const buttonLeft = section.querySelector(".button-left");
    const buttonRight = section.querySelector(".button-right");

    const itemWidth = 50 * 10; // Assuming 25rem for item width and 1rem = 16px

    buttonLeft.addEventListener("click", function (event) {
      event.preventDefault();
      itemContainer.scrollBy({
        left: -itemWidth,
        behavior: "smooth"
      });
    });

    buttonRight.addEventListener("click", function (event) {
      event.preventDefault();
      itemContainer.scrollBy({
        left: itemWidth,
        behavior: "smooth"
      });
    });
  });
});

// Cart
let cartContainer = document.querySelector('.cart-container');
let cartICon = document.querySelector('.cart-container i');
let cart = document.querySelector('.cart-list-container');


cartContainer.onclick = () => {
  if (cart.style.display === 'none' || cart.style.display === '') {
    cart.style.display = 'block';
    cartICon.classList.add('fa-xmark');
  } else {
    cart.style.display = 'none';
    cartICon.classList.remove('fa-xmark');
  }
};

// Order to cart
let itemOrder = document.querySelectorAll('.item-order');
let cartList = document.querySelector('.cart-list');


let list = [];

itemOrder.forEach((e) => {
  let orderBtn = (e.querySelector('.orderBtn'));
  let id = e.querySelector('input').value;
  let img = e.querySelector('img').src;
  let name = e.querySelector('.item-name').textContent;
  let price = e.querySelector('.item-price').textContent;
  orderBtn.onclick = () => {
    // console.log(id);
    // console.log(name);
    // console.log(img);
    console.log(price);
    let currItem = list.find(e => e.id === id);
    if (currItem) {
      console.log(1);
      currItem.quantity += 1;
    } else {
      addItem(id, img, name, price, 1);
    }
    console.log(list);
    updateCartList();
  };
});

// increase or decrease item



function changeQuantityCart() {
  let cartItem = document.querySelectorAll('.cart-item');
  cartItem.forEach((e) => {
    let increase = e.querySelector('.fa-plus');
    let decrease = e.querySelector('.fa-minus');
    let removeIcon = e.querySelector('.fa-xmark');
    let remove = e.querySelector('.cart-remove');
    let id = e.querySelector('input').value;
    increase.onclick = () => {
      let currItem = list.find(e => e.id === id);
      currItem.quantity += 1;
      console.log(list);
      updateCartList();
    };
    decrease.onclick = () => {
      let currItem = list.find(e => e.id === id);
      if (currItem.quantity <= 1) {
        list = list.fil;ter(e => e.id !== id);
      } else {
        currItem.quantity -= 1;
      }
      updateCartList();
    };
    removeIcon.onclick = () => {
      list = list.filter(e => e.id !== id);
      updateCartList();
    };
    remove.onclick = () => {
      list = list.filter(e => e.id !== id);
      updateCartList();
    };
  });
}



function addItem(id, img, name, price, quantity) {
  const item = { id, img, name, price, quantity };
  list.push(item);
}


//update order cart
function updateCartList() {
  let out = `<input type="hidden" name="numItem" value="${Object.keys(list).length}">`;
  var i = 1;
  list.forEach(e => {
    out += `
          <div class="cart-item col l-12">
            <div class="row">
              <input type="hidden" name="idItem${i}" value="${e.id}">
              <input type="hidden" name="quantityItem${i++}" value="${e.quantity}">
              <div class="cart-item-img col l-5 c-12">
                <div class="row">
                  <img src="${e.img}" alt="" class=" col l-3 c-5">
                  <div class="cart-item-name col l-9 c-7">${e.name}</div>
                </div>
              </div>

              <div class="cart-item-price col l-2 c-4 ">${e.price}</div>
              <div class="cart-item-quantiy col l-2 c-4">
                <i class="fa-solid fa-minus"></i>
                ${e.quantity}
                <i class="fa-solid fa-plus"></i>
              </div>

              <div class="cart-item-total col l-2 hide-on-moblile">${parseInt(e.price.replace(/[^\d]/g, '')) * parseInt(e.quantity)}</div>

              <div class="cart-item-remove col l-1 hide-on-moblile">
                <i class="fa-solid fa-xmark"></i>
              </div>

              <button class="cart-remove col c-4">REMOVE</button>
              </div>

        </div>

          `;
  });
  // console.log(out);
  cartList.innerHTML = out;
  changeQuantityCart();

}

//slider
let sliderList = document.querySelector('.slider-list');
let sliderItem = document.querySelectorAll('.slider-item');
let sliderDot = document.querySelectorAll('.slider-dot li');
let prev = document.getElementById('slider-button_pre');
let next = document.getElementById('slider-button_next');

console.log(next);

let active = 0;
let lengthItems = sliderItem.length - 1;

// next btn
next.onclick = function () {
  if (active + 1 > lengthItems) {
    active = 0;
  } else {
    active++;
  }
  reloadSlider();
};

// prev btn
prev.onclick = function () {
  if (active - 1 < 0) {
    active = lengthItems;
  } else {
    active--;
  }
  reloadSlider();
};

// auto chuyển slider
let refeshSlider = setInterval(() => { next.click(); }, 5000);

function reloadSlider() {
  let checkLeft = sliderItem[active].offsetLeft;
  sliderList.style.left = -checkLeft + 'px';

  //lấy dot đang được active (xoá và trở lại bth)
  let lastActiveDot = document.querySelector('.dot-item__active');
  lastActiveDot.classList.remove('dot-item__active');
  lastActiveDot.classList.add('dot-item');

  // lấy dot kế tiếp xoá và thêm active
  sliderDot[active].classList.remove('dot-item');
  sliderDot[active].classList.add('dot-item__active');

  //xoá thời gian đếm auto chuyển slider và gọi lại để đếm lại từ đầu
  clearInterval(refeshSlider);
  refeshSlider = setInterval(() => { next.click(); }, 5000);
}

sliderDot.forEach((li, key) => {
  li.addEventListener('click', function () {
    active = key;
    reloadSlider();
  });
});