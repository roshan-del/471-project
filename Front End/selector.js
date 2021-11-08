//Make
const selectedMake = document.querySelector(".selected-maker");
const optionsContainerMake = document.querySelector(".options-container-maker");

const optionsListMake = document.querySelectorAll(".option-maker");

selectedMake.addEventListener("click", () => {
  optionsContainerMake.classList.toggle("active");
});

optionsListMake.forEach((o) => {
  o.addEventListener("click", () => {
    selectedMake.innerHTML = o.querySelector("label").innerHTML;
    optionsContainerMake.classList.remove("active");
  });
});

// //Model
// const selectedModel = document.querySelector(".selected-model");
// const optionsContainerModel = document.querySelector(
//   ".options-container-model"
// );

// const optionsListModel = document.querySelectorAll(".option-model");

// selectedModel.addEventListener("click", () => {
//   optionsContainerModel.classList.toggle("active");
// });

// if (optionsListModel.length != 0) {
//   optionsListModel.forEach((o) => {
//     o.addEventListener("click", () => {
//       selectedModel.innerHTML = o.querySelector("label").innerHTML;
//       optionsContainerModel.classList.remove("active");
//     });
//   });
// }
//Year
const selectedYear = document.querySelector(".selected-year");
const optionsContainerYear = document.querySelector(".options-container-year");

const optionsListYear = document.querySelectorAll(".option-year");

selectedYear.addEventListener("click", () => {
  optionsContainerYear.classList.toggle("active");
});

optionsListYear.forEach((o) => {
  o.addEventListener("click", () => {
    selectedYear.innerHTML = o.querySelector("label").innerHTML;
    optionsContainerYear.classList.remove("active");
  });
});
