const products = [
    {
        name: "og_kush",
        lable: "OG Kush",
        type: "sativa",
        thc: "10%",
        image_url: "https://cdn.prod.website-files.com/662a7e8c1cc81d761dfa2dcb/6728e365a200f8dc2fd0e2c3_imc%20thc22%20t02%20og%20kush.png"
    },
    {
        name: "blue_dream",
        lable: "Blue Dream",
        type: "hybrid",
        thc: "18%",
        image_url: "https://cbd-deal24.de/wp-content/uploads/2023/06/blue-dream-cannabisbluete.png"
    },
    {
        name: "sour_diesel",
        lable: "Sour Diesel",
        type: "sativa",
        thc: "15%",
        image_url: "https://cbd-deal24.de/wp-content/uploads/2023/06/sour-diesel-cannabisbluete.png"
    },
    {
        name: "granddaddy_purple",
        lable: "Granddaddy Purple",
        type: "indica",
        thc: "20%",
        image_url: "https://cbd-deal24.de/wp-content/uploads/2023/06/granddaddy-purple-cannabisbluete.png"
    },
    {
        name: "white_widow",
        lable: "White Widow",
        type: "hybrid",
        thc: "22%",
        image_url: "https://cbd-deal24.de/wp-content/uploads/2023/06/white-widow-cannabisbluete.png"
    }
]


$(document).ready(function () {
    // Dynamically create product cards
    products.forEach(product => {
        const card = `
        <div class="shop-item" style="display: flex; width: 100%; gap: 4rem; align-items: center; justify-content: space-between;">
            <div>
                <img src="${product.image_url}" alt="Cannabis Seed" style="height: 10rem;">
            </div>
            <div>
                <h2 class="text-5xl">${product.lable}</h2>
                <p class="text-2xl">THC: ${product.thc}</p>
                <p class="text-2xl">${product.type}</p>
            </div>
            <div>
                <p class="text-5xl text-green-800">150$</p>
            </div>
            <div>
                <button class="text-3xl text-white px-6 py-4 bg-green-800 rounded-lg hover:shadow-xl hover:bg-green-900">kaufen</button>
            </div>
        </div>
        `;
        $('#item-container').append(card);
    });

    // Add hover effect
    $('.product-card').hover(
        function() {
            $(this).addClass('hovered');
        },
        function() {
            $(this).removeClass('hovered');
        }
    );
});