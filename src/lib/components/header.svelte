<script>
    import { Button } from "m3-svelte";
</script>

<div class="header">
    <div class="left">
        <img src="/logo/logo-large.svg" alt="QwicClick Logo" />
    </div>
    <div class="right">
        <Button variant="text" square="true" href="/auth?login">Login</Button>
        <Button variant="filled" square="true" href="/auth?signup"
            >Signup</Button
        >
    </div>
</div>

<style>
    .header {
        width: 100%;
        height: 6rem;
        padding: 2rem;
        display: flex;
        justify-content: space-between;
        box-sizing: border-box;

        .left {
            display: flex;
            align-items: center;

            img {
                height: 3rem;
            }
        }

        .right {
            align-items: center;
            display: flex;
            gap: 1rem;
        }
    }
</style>
