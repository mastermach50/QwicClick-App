<script>
    import { slide } from "svelte/transition";
    import { createEventDispatcher } from "svelte";
    import { Button, TextFieldOutlined} from "m3-svelte";
    import signup from "../signup/+page.svelte";
    

    let login_field = { login_usn: "", login_pwd: "" };
    let errors = { login_usn: "", login_pwd: "" };
    let [error_usn, error_pwd] =[false, false];

    const checkFields = () => {

        if (login_field.login_usn.length < 6) {
            error_usn = true;
            errors.login_usn = "Username must be at least 6 characters long !";
        } else {
            errors.login_usn = "";
        }

        if (login_field.login_pwd.length < 8) {
            error_pwd = true;
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
                <h3 id="login_head">Login</h3>
                <div id="login_usn_div">
                    
                    <TextFieldOutlined
                        id="login_usn"
                        type="text"
                        label="Username"
                        error={error_usn}
                        bind:value={login_field.login_usn}
                    /><br />
                    <div class="error">{errors.login_usn}</div><br />
                </div>
                <div id="login_pwd_div">
                    
                    <TextFieldOutlined
                        id="login_pwd"
                        type="password"
                        label="Password"
                        error={error_pwd}
                        bind:value={login_field.login_pwd}    
                    /><br />
                    <div class="error">{errors.login_pwd}</div>
                </div>
                <div class="login_btn"><Button variant="filled" square=True >LOGIN</Button></div>
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

    .error {
        color: red;
        font-size: 15px;
        text-align: center;

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
    :global(.m3-container.s-0BLyfdqucHde){
        min-width: 20rem !important;
        height: 3.5rem !important;
        margin-bottom: 0.5rem;
    }
    /*Change input text color */
    :global(.m3-container input[type="text"]) {
        color: black;
    }
    :global(.m3-container input[type="password"]) {
        color: black;
    }





</style>
