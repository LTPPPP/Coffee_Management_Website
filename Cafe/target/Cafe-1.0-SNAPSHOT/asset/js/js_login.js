

// Đóng mở role và selecet
const role = document.querySelector('.login-role'),
    selectBtn = role.querySelector('.select-btn'),
    option = role.querySelectorAll('.option'),
    selectText = role.querySelector('.select-text');

selectBtn.addEventListener('click', () => role.classList.toggle('active'));

option.forEach(e => {
    e.addEventListener('click', () => {
        let selectOption = e.querySelector('span').innerText;
        selectText.innerText = selectOption;
        role.classList.remove('active');
    })
})


// Hiển thị các login theo từng role
const customerContain = document.querySelector('.login-customer'),
    staffContain = document.querySelector('.login-staff'),
    managerContain = document.querySelector('.login-manager');


option.forEach(e => {
    e.addEventListener('click', () => {
        switch (selectText.innerText) {
            case 'CUSTOMER':
                customerContain.style.display = 'block';
                staffContain.style.display = 'none';
                managerContain.style.display = 'none';
                break;
            case 'STAFF':
                customerContain.style.display = 'none';
                staffContain.style.display = 'block';
                managerContain.style.display = 'none';
                break;
            case 'MANAGER':
                customerContain.style.display = 'none';
                staffContain.style.display = 'none';
                managerContain.style.display = 'block';
                break;
            default:
                customerContain.style.display = 'none';
                staffContain.style.display = 'none';
                managerContain.style.display = 'none';
        }
    })
})