<style>

    /* Màu chữ mặc định */
    .card-title a {
        color: black;
        text-decoration: none; /* Loại bỏ gạch chân mặc định */
        display: block;
        word-wrap: break-word;
        max-width: 250px;
    }

    /* Màu chữ khi hover */
    .card-title a:hover {
        transition: 0.3s ease;
        color: #e07c51;
        display: block;
        word-wrap: break-word;
        max-width: 250px;
    }

    /* Phần viền chỉ bao quanh ảnh */
    .card {
        border: none;
        border-radius: 12px; /* Độ cong của góc */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .card-img-top {
        object-fit: cover;
        border-radius: 12px;
    }

    /* Loại bỏ phần viền của .card-body */
    .card-body {
        border: none;
    }
</style>

<div class="container">
    <div class="card" style="width: 18rem;">
        <a href="login">
            <img class="card-img-top"
                 src="https://product.hstatic.net/1000075078/product/1675355354_bg-tch-sua-da-no_4fbf208885ed464ab4b5e145336d42a2_large.jpg"
                 alt="Card image cap">
        </a>
    </div>
    <div class="card-body">
        <h5 class="card-title"><a href="login">Black Sugar Marble Latte</a></h5>
        <p class="card-text">20.000 đ</p>
    </div>
</div>