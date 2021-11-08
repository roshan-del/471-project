// //Category Name
const selectedCategoryName = document.querySelector(".selected-category-name");
const optionsContainerCategoryName = document.querySelector(
  ".options-container-category-name"
);

const optionsListCategoryName = document.querySelectorAll(
  ".option-category-name"
);

selectedCategoryName.addEventListener("click", () => {
  optionsContainerCategoryName.classList.toggle("active");
});

optionsListCategoryName.forEach((o) => {
  o.addEventListener("click", () => {
    selectedCategoryName.innerHTML = o.querySelector("label").innerHTML;
    optionsContainerCategoryName.classList.remove("active");
  });
});

// //Retailers Name
const selectedRetailersName = document.querySelector(".selected-retailer-name");
const optionsContainerRetailersName = document.querySelector(
  ".options-container-retailer-name"
);

const optionsListRetailersName = document.querySelectorAll(
  ".option-retailer-name"
);

selectedRetailersName.addEventListener("click", () => {
  optionsContainerRetailersName.classList.toggle("active");
});

optionsListRetailersName.forEach((o) => {
  o.addEventListener("click", () => {
    selectedRetailersName.innerHTML = o.querySelector("label").innerHTML;
    optionsContainerRetailersName.classList.remove("active");
  });
});

// //Ratings Name
const selectedRatingsName = document.querySelector(".selected-rating-name");
const optionsContainerRatingsName = document.querySelector(
  ".options-container-rating-name"
);

const optionsListRatingsName = document.querySelectorAll(".option-rating-name");

selectedRatingsName.addEventListener("click", () => {
  optionsContainerRatingsName.classList.toggle("active");
});

optionsListRatingsName.forEach((o) => {
  o.addEventListener("click", () => {
    selectedRatingsName.innerHTML = o.querySelector("label").innerHTML;
    optionsContainerRatingsName.classList.remove("active");
  });
});
