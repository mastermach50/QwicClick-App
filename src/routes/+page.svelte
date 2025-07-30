<script>
    import Header from "$lib/components/header.svelte";
    import "$lib/m3.css";
</script>

<Header />

<div class="content"></div>
<div class="footer">
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

    .footer {
        display: flex;
        justify-content: space-between;
        padding: 4rem;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 12rem;
        box-sizing: border-box;
        .logo {
            width: 210px;
            height: auto;
        }
        .copyright {
            text-align: right;
        }
    }

</style>
