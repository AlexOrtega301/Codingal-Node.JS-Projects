const searchInput = document.getElementById("searchInput");
const searchBtn = document.getElementById("searchBtn");
const resultsContainer = document.getElementById("results");
const message = document.getElementById("message");

// click on search button
searchBtn.addEventListener("click", handleSearch);

// press enter to search
searchInput.addEventListener("keyup", function (event) {
  if (event.key === "Enter") {
    handleSearch();
  }
});


function handleSearch() {
  const query = searchInput.value.trim();

  if (!query) {
    message.textContent = "Please type a dish name to search.";
    resultsContainer.innerHTML = "";
    return;
  }

  message.textContent = "Searching recipes...";
  resultsContainer.innerHTML = "";

  fetch("https://www.themealdb.com/api/json/v1/1/search.php?s=" + encodeURIComponent(query))
    .then(function (response) {
      return response.json();
    })
    .then(function (data) {
      if (!data.meals) {
        message.textContent = "No recipes found. Try another dish.";
        resultsContainer.innerHTML = "";
        return;
      }

      message.textContent = "Found " + data.meals.length + " recipe(s).";
      displayResults(data.meals);
    })
    .catch(function () {
      message.textContent = "Something went wrong. Please try again.";
      resultsContainer.innerHTML = "";
    });
}

function fetchDetails(id) {
  message.textContent = "Loading recipe details...";

  fetch("https://www.themealdb.com/api/json/v1/1/lookup.php?i=" + id)
    .then(function (response) {
      return response.json();
    })
    .then(function (data) {
      if (!data.meals || !data.meals[0]) {
        message.textContent = "Unable to load details.";
        return;
      }

      showModal(data.meals[0]);
      message.textContent = "";
    })
    .catch(function () {
      message.textContent = "Something went wrong fetching details.";
    });
}

function displayResults(meals) {
  resultsContainer.innerHTML = "";

  meals.forEach(function (meal) {
    const col = document.createElement("div");
    col.className = "col-12 col-sm-6 col-md-4 col-lg-3 d-flex";

    col.innerHTML = `
      <div class="card recipe-card h-100 w-100">
        <img src="${meal.strMealThumb}" class="card-img-top" alt="${meal.strMeal}">
        <div class="card-body d-flex flex-column">
          <h6 class="card-title mb-2 fw-semibold">${meal.strMeal}</h6>
          <p class="card-text text-muted mb-2">
            ${meal.strArea || "World cuisine"} • ${meal.strCategory || "Dish"}
          </p>
          <button
            class="btn btn-outline-primary btn-sm mt-auto view-btn"
            data-id="${meal.idMeal}">
            View details
          </button>
        </div>
      </div>
    `;

    resultsContainer.appendChild(col);
  });
}

document.addEventListener("click", function (event) {
  if (event.target.classList.contains("view-btn")) {
    const id = event.target.getAttribute("data-id");
    fetchDetails(id);
  }
});
