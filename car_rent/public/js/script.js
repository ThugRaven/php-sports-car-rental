// let menu = document.querySelector(".nav__icon--menu");
// let sideBar = document.querySelector(".side-nav");

// menu.onclick = function () {
// 	sideBar.classList.toggle("active");
// };

let slides = document.querySelectorAll(".swiper__slide");
let slideNext = document.getElementsByClassName("swiper__button--next");
let slidePrev = document.getElementsByClassName("swiper__button--prev");

//TODO: Change buttons to make AJAX calls. Maybe later add some animation to the background and text.


// slideNext[0].addEventListener("click", () => {
// 	for (let i = 0; i < slides.length; i++) {
// 		const item = slides[i];

// 		if (item.classList.contains("swiper__slide--active")) {
// 			if (i + 1 > slides.length - 1) {
// 				return;
// 			}

// 			item.classList.remove("swiper__slide--active");
// 			slides[i + 1].classList.add("swiper__slide--active");

// 			return;
// 		}
// 	}
// });

// slidePrev[0].addEventListener("click", () => {
// 	for (let i = 0; i < slides.length; i++) {
// 		const item = slides[i];
// 		if (item.classList.contains("swiper__slide--active")) {
// 			if (i - 1 < 0) {
// 				return;
// 			}

// 			item.classList.remove("swiper__slide--active");
// 			slides[i - 1].classList.add("swiper__slide--active");

// 			return;
// 		}
// 	}
// });
