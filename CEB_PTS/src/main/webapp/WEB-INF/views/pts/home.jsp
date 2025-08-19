<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home Page</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background-color: #FFD900;
            position: relative;
            overflow: hidden;
            font-family: "Helvetica";
        }

        .background-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 80%;
            background-image: url('img/banner/new_home.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            z-index: -1;
        }

        .logout-container {
            position: absolute;
            top: 20px;
            left: 30px;
            z-index: 2;
        }

        .logout-container:hover {
            border-bottom: 4px solid white;
            transition: border-bottom 0.3s ease;
        }

        .logout-link {
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .logout-text {
            font-weight: bold;
            color: white;
        }

        .title-container {
            position: absolute;
            top: 35%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1;
        }

        .system-title {
            font-size: 32px;
            font-weight: bold;
            color: #fff;
            padding: 10px 20px;
            border-radius: 10px;
            text-align: center;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
        }

        .card-container {
            position: absolute;
            top: 75%;
            left: 50%;
            transform: translate(-50%, -20%);
            display: flex;
            flex-direction: row;
            gap: 20px;
        }

        .card {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            width: 300px;
            height: 80px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card h3 {
            margin: 0;
            color: #ffffff;
        }

        .enabled-card {
            background-color: #7D0000;
        }

        .disabled-card {
            background-color: #7D0000;
            opacity: 0.5;
            cursor: not-allowed;
        }

        .disabled-card h3 {
            color: #ffffff;
        }

        .disabled-card img {
            filter: grayscale(20%);
        }

        .slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }

        .slide.active {
            opacity: 1;
        }

        @media (max-width: 767px) {
            .title-container {
                top: 20%;
            }
            .card-container {
                flex-direction: column;
                top: 60%;
                gap: 10px;
            }
        }
    </style>
</head>
<body>

<!-- Background Image -->
<div class="background-image">
    <div class="slide active" style="background-image: url('img/banner/new_home.jpg');"></div>
    <div class="slide" style="background-image: url('img/banner/welcome.png');"></div>
    <div class="slide" style="background-image: url('img/banner/home2.jpg');"></div>
</div>

<!-- Logout Section -->
<div class="logout-container">
    <a href="WelcomePTS" class="logout-link">
        <span class="logout-text">Logout</span>
    </a>
</div>

<!-- Page Title -->
<div class="title-container">
    <div class="system-title">Energy Marketing System</div>
</div>

<!-- Cards Section -->
<div class="card-container">
    <!-- Distribution Licensee Billing Card -->
    <c:choose>
        <c:when test="${fn:trim(fn:toUpperCase(sessionScope.USER_LEVEL)) != 'ACCNT'}">
            <a href="licenseeBillingHome" style="text-decoration: none;">
                <div class="card enabled-card">
                    <img src="resources/icons/electricity.svg" alt="Icon" style="width: 50px; height: 50px; margin-right: 10px; filter:invert(1);">
                    <div><h3>Distribution Licensee Billing</h3></div>
                </div>
            </a>
        </c:when>
        <c:otherwise>
            <div class="card disabled-card">
                <img src="resources/icons/electricity.svg" alt="Icon" style="width: 50px; height: 50px; margin-right: 10px; filter:invert(1)">
                <div><h3>Distribution Licensee Billing</h3></div>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Transmission Consumer Billing Card -->
    <c:choose>
        <%--        <c:when test="${fn:trim(fn:toUpperCase(sessionScope.USER_LEVEL)) == 'ACCNT'}">--%>
        <c:when test="${true}">
            <a href="consumerBillingHome" style="text-decoration: none;">
                <div class="card enabled-card">
                    <img src="resources/icons/transmission-tower.svg" alt="Icon" style="width: 50px; height: 50px; margin-right: 10px; filter:invert(1);">
                    <div><h3>Transmission Consumer Billing</h3></div>
                </div>
            </a>
        </c:when>
        <c:otherwise>
            <div class="card disabled-card">
                <img src="resources/icons/transmission-tower.svg" alt="Icon" style="width: 50px; height: 50px; margin-right: 10px;filter:invert(1);">
                <div><h3>Transmission Consumer Billing</h3></div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script>
    let slideIndex = 0;
    const slides = document.querySelectorAll('.slide');

    function showNextSlide() {
        slides[slideIndex].classList.remove('active');
        slideIndex = (slideIndex + 1) % slides.length;
        slides[slideIndex].classList.add('active');
    }

    // Auto slide every 4 seconds
    setInterval(showNextSlide, 4000);
</script>
</body>