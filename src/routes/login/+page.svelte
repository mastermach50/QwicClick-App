<script>
    import { slide } from "svelte/transition";
    import { createEventDispatcher } from "svelte";
    import { Button } from "m3-svelte";

    let login_field = { login_usn: "", login_pwd: "" },
        valid = false;
    let errors = { login_usn: "", login_pwd: "" };

    const checkFields = () => {
        valid = true;

        if (login_field.login_usn.length < 6) {
            valid = false;
            errors.login_usn = "Username must be at least 6 characters long !";
        } else {
            errors.login_usn = "";
        }

        if (login_field.login_pwd.length < 8) {
            valid = false;
            errors.login_pwd = "Password must be at least 8 characters long !";
        } else {
            errors.login_pwd = "";
        }
    };
</script>

<main>
    <div class="leftside">
        <div class="formfield">
            <form class="login form" on:submit|preventDefault={checkFields}>
                <h3>Login</h3>
                <div>
                    <label for="login_usn">Username : </label><br />
                    <input
                        id="login_usn"
                        type="text"
                        placeholder="Enter Username.. "
                        bind:value={login_field.login_usn}
                    /><br />
                    <div class="error">{errors.login_usn}</div>
                </div>
                <div>
                    <label for="login_pwd">Password : </label><br />
                    <input
                        id="login_pwd"
                        type="password"
                        placeholder="Enter Password.. "
                        bind:value={login_field.login_pwd}
                    /><br />
                    <div class="error">{errors.login_pwd}</div>
                </div>
                <div class="login_btn"><Button variant="filled">LOGIN</Button></div>
                <a href="/signup">New User? Click to SignUp</a>
            </form>
        </div>
    </div>

    <div class="rightside">
        <div class="logo">
            <img src="logo/logo-large.svg" alt="QwicClick Logo" />
        </div>

        <div class="slogans">
            <em>"Shrink Smart.&nbsp; Track Smarter."</em><br />
            <em>"Beyond Short Links — Real-Time Insights."</em><br />
            <strong>powered by Qwic.Click</strong>
        </div>
    </div>
</main>

<style>
    main {
        display: grid;
        grid-template-columns: 1fr 1fr;
        margin: 0px auto;
    }

    .leftside {
        display: flex;
        justify-content: center;
        align-items: center;

        width: 50vw;
        height: 100vh;

        background-image: url("/LoginBackground.jpg");
        background-size: cover;
    }

    h3 {
        text-align: center;
        font-weight: bold;
        color: black;
        text-shadow: 1px 1px white;
        font-size: 2rem;
    }

    .rightside {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .slogans {
        text-align: center;
        font-size: 25px;

        strong {
            text-align: right;
        }
    }

    .formfield {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;

        padding: 3rem;

        border: 2px solid white;
        border-radius: 5%;
        box-shadow: 1px 2px 1px white;

        width: 25vw;

        background: white;
    }

    label {
        font-size: 18px;
        text-shadow: 0px 0px 0.3px black;
        margin-top: 10px;
        color: black;
    }
    .error {
        color: red;
        font-size: 15px;
        text-align: center;

        margin-bottom: 10px;
    }
    input {
        width: 300px;
        height: 25px;

        padding: 5px;

        background: transparent;

        border: 2px solid black;
        border-radius: 10px;

        margin-top: 10px;
        margin-bottom: 10px;
    }

    a {
        color: darkblue;
        text-decoration: none;
    }

    .login_btn {
        text-align: center;
        margin-bottom: 1rem;
    }
</style>
