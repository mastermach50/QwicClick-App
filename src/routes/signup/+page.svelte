<script>
    import "$lib/daisy.css";

    let email = $state(null);
    let password = $state(null);
</script>

<div class="left">
    <div class="box">
        <h1>Signup</h1>
        <div class="username">
            <label class="input validator">
                <img style="height: 1em; opacity: 0.5;" src="/svg/person.svg" alt="" />
                <input
                    type="text"
                    required
                    placeholder="Username"
                    pattern="[A-Za-z][A-Za-z0-9\-]*"
                    minlength="3"
                    maxlength="30"
                />
            </label>
            <div class="validator-hint hidden">Must be 3 to 30 characters</div>
        </div>
        <div class="email">
            <label class="input validator">
                <img style="height: 1em; opacity: 0.5;" src="/svg/mail.svg" alt="" />
                <input type="email" placeholder="Email" bind:value={email} required />
            </label>
            <div class="validator-hint hidden">Enter valid email address</div>
        </div>
        <div class="password">
            <label class="input validator">
                <img style="height: 1em; opacity: 0.5;" src="/svg/key.svg" alt="" />
                <input
                    type="password"
                    placeholder="Password"
                    minlength="8"
                    bind:value={password}
                    required
                />
            </label>
            <div class="validator-hint hidden">Must be more than 8 characters</div>
        </div>
        <button class="btn btn-primary rounded-4xl" type="submit">Login</button>
        <p>Already a user? <a href="/login">Login</a></p>
    </div>
</div>
<div class="right">
    <img src="/logo/logo-large.svg" alt="">
</div>

<style>
    .left {
        width: 50vw;
        height: 100vh;
        background-image: url("/LoginBackground.jpg");
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .right {
        position: absolute;
        right: 0;
        top: 0;
        width: 50vw;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .right img {
        height: 10vh;
    }

    .box {
        height: 50vh;
        width: 30vw;
        padding: 2rem;
        background-color: white;
        border-radius: 2rem;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: space-evenly;
    }

    h1 {
        font-weight: 900;
        font-size: 2rem;
    }

    p a {
        text-decoration: underline;
        color: var(--color-secondary);
    }
</style>
