<script>
    import Error from "$lib/components/alerts/error.svelte";
    import Email from "$lib/components/textfields/email.svelte";
    import Password from "$lib/components/textfields/password.svelte";
    import Username from "$lib/components/textfields/username.svelte";
    import "$lib/daisy.css";

    let email = $state(null);
    let password = $state(null);
    let username = $state(null);
    let errorMessage = $state(null);
    let alertRef;

    async function onSubmit(e) {
        e.preventDefault();
        console.log(email, password);
        const response = await fetch("https://qwic.click/api/register", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                email: email,
                password: password,
                username: username,
            }),
        });
        if (response.status === 200) {
            const data = await response.json();
            window.location.href = "/login";
        } else {
            errorMessage = await response.text();
            alertRef.show();
            console.log("Error: " + errorMessage);
        }
    }
</script>

<Error message={errorMessage} bind:this={alertRef} />
<div class="left">
    <form class="box">
        <h1>Signup</h1>
        <Username bind:value={username} />
        <Email bind:value={email} />
        <Password bind:value={password} />
        <button class="btn btn-primary rounded-4xl" type="submit" onclick={onSubmit}
            >Signup</button
        >
        <p>Already a user? <a href="/login">Login</a></p>
    </form>
</div>
<div class="right">
    <img src="/logo/logo-large.svg" alt="" />
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
