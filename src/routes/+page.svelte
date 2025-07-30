<script>
    import Header from "$lib/components/header.svelte";
    import "$lib/m3.css";
</script>

<Header />

<div class="content">

</div>
<div class="bottom">
    <img src="/logo/logo-medium.svg" alt="QwicClick Logo" class="logo" />
    <div class="copyright">
        <p>&copy; 2025 Qwic.click. All rights reserved.</p>
    </div>
</div>

<style>
    .content {
        min-height: 100vh;
        background-image: url("/polka.png");
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
    }

    .logo {
        width: 210px;
        height: auto; /* Use auto height to maintain aspect ratio */
    }

    .bottom {
        display: flex; /* Activates Flexbox */
        justify-content: space-between; /* Centers the logo in the footer */
        align-items: center; /* Vertically aligns it in the middle */
        padding: 50px 20px 30px; /* Adds some nice spacing */
        background-color: #141414;
        bottom: 0;
        left: 0;
        width: 97.5%;
        height: 70px;
    }

    .copyright {
        color: rgba(191, 172, 255, 1);
        display: flex;
        padding-left: 65%;
        font-family: "Nunito", "Arial Rounded MT Bold", sans-serif;
        font-weight: bold;
        text-align: center;
        width: 100%;
        right: 100%;
    }
</style>
